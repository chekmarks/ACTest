
#import "ACContactListXMLElement.h"

__strong NSDictionary* elementsByName = NULL;

XMLElement XMLElementFromNSString( NSString* elementName )
{
	if(!elementsByName) elementsByName = @
	{
			@"contacts"  : [NSNumber numberWithInt:XMLElementContactList],
			@"contact"   : [NSNumber numberWithInt:XMLElementContact],
			@"firstName" : [NSNumber numberWithInt:XMLElementFirstName],
			@"lastName"  : [NSNumber numberWithInt:XMLElementLastName],
			@"age"       : [NSNumber numberWithInt:XMLElementAge],
			@"sex"       : [NSNumber numberWithInt:XMLElementSex],
			@"picture"   : [NSNumber numberWithInt:XMLElementPicture],
			@"notes"     : [NSNumber numberWithInt:XMLElementNotes]
	};

    __strong NSNumber *elementNumber = elementsByName[ elementName ];

	return elementNumber ? ((XMLElement)[elementNumber intValue]) : XMLElementUnknown;
}

void XMLElementFromNSStringPurgeCache()
{
	elementsByName = NULL;
}