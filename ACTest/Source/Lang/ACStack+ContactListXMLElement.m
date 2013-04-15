//
// Created by Chris Hatton on 06/04/2013.
//

#import "ACStack+ContactListXMLElement.h"

@implementation ACStack (ContactListXMLElement)

- (void)pushElement:(XMLElement)element
{
	[self push:@(element)];
}

- (XMLElement)peekElement
{
	return (XMLElement)[((NSNumber*)[self peek]) intValue];
}

- (XMLElement)popElement
{
	return (XMLElement)[((NSNumber*)[self pop]) intValue];
}

@end