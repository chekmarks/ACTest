//
// Created by Chris Hatton on 05/04/2013.
//

#import "ACContactListDeserializer.h"
#import "ACContact.h"
#import "ACStack.h"
#import "ACContactListXMLElement.h"
#import "ACStack+ContactListXMLElement.h"

static NSObject *mutex;

@implementation ACContactListDeserializer
{
	__strong NSMutableString     *characters;
	__strong ACContact *contact;
	__strong NSMutableOrderedSet *contactList;
	__strong NSXMLParser         *parser;
	__strong NSNumberFormatter   *numberFormatter;

	__strong ACStack *xmlElementStack;
}

+(void)initialize
{
    mutex = [NSObject new];
}

/**
* Parses the provided Contact List XML data and returns a corresponding data model.
* If parsing fails, this method returns NULL and provides an error via the errorRef reference.
*/
-(NSOrderedSet*)contactListFromData:(NSData *)contactListData
                              error:(NSError**)errorRef;
{
	@synchronized( mutex ) // Prevent concurrency, within this thread-unsafe method
	{
		numberFormatter = [NSNumberFormatter new];
		characters      = [NSMutableString new];
		xmlElementStack = [ACStack new];

		parser = [[NSXMLParser alloc] initWithData:contactListData];
		parser.delegate = self;
		[parser parse];

		if(errorRef) *errorRef = parser.parserError;

		xmlElementStack = nil;
		parser          = nil;
		numberFormatter = nil;
		characters      = nil;

		return (errorRef && *errorRef) ? NULL : [NSOrderedSet orderedSetWithOrderedSet:contactList];
	}
}

#pragma mark NSXMLParser delegate methods begin

- (void) parser:(NSXMLParser*)  parserIn
didStartElement:(NSString*)     elementName
   namespaceURI:(NSString*)     namespaceURI
  qualifiedName:(NSString*)     qName
	 attributes:(NSDictionary*) attributeDict
{
	NSAssert( parserIn == parser, NSInternalInconsistencyException );

	XMLElement element = XMLElementFromNSString( elementName );

	[xmlElementStack pushElement:element];

	switch( element )
	{
		case XMLElementContactList:
            contactList = [NSMutableOrderedSet new];
            break;

		case XMLElementContact:
            contact = [ACContact new];
            break;

		default: break;
	}

	[characters setString:@""];
}

- (void)parser:(NSXMLParser*) parserIn
 didEndElement:(NSString*)    elementName
  namespaceURI:(NSString*)    namespaceURI
 qualifiedName:(NSString*)    qName
{
	NSAssert( parserIn == parser, NSInternalInconsistencyException );

	XMLElement element = [xmlElementStack popElement];

	NSAssert( XMLElementFromNSString( elementName ) == element, NSInternalInconsistencyException );

	switch( element )
	{
		case XMLElementContactList: break;
		case XMLElementContact:
		{
			[contactList addObject:contact];
		}
		break;

		default: // Properties
		{
			NSAssert( contact, NSInternalInconsistencyException );

			NSString* charactersString = [characters stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

			switch( element )
			{
				case XMLElementFirstName:  contact.firstName = charactersString; break;
				case XMLElementLastName:   contact.lastName  = charactersString; break;
				case XMLElementNotes:      contact.notes     = charactersString; break;

				case XMLElementAge:        contact.age       = [[numberFormatter numberFromString:charactersString] unsignedIntegerValue]; break;

				case XMLElementSex:        contact.sex       = MTContactGenderFromString( charactersString ); break;

				case XMLElementPicture:    contact.photoUrl  = [NSURL URLWithString:charactersString]; break;

				default: @throw [NSException exceptionWithName:NSInternalInconsistencyException
				                                        reason:[NSString stringWithFormat:@"Unknown element value %d", element]
					                                  userInfo:NULL];
			}
		}
		break;
	}
}

- (void) parser:(NSXMLParser*) parserIn
foundCharacters:(NSString*)    charactersIn
{
	NSAssert( parserIn == parser, NSInternalInconsistencyException );

	[characters appendString:charactersIn];
}

- (void)parser:(NSXMLParser*) parserIn
    foundCDATA:(NSData*)      CDATABlock
{
	NSAssert( parserIn == parser, NSInternalInconsistencyException );

	__strong NSString* charactersIn = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];

	[characters appendString:charactersIn];
}

#pragma mark NSXMLParser delegate methods end

@end