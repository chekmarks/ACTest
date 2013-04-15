//
// Created by Chris Hatton on 06/04/2013.
//

#import <Foundation/Foundation.h>

#import "ACStack.h"
#import "ACContactListXMLElement.h"

/**
* Adds convenience methods to ACStack, to box and un-box XMLElement value types,
* for use during SAX style XML parsing.
*/
@interface ACStack (ContactListXMLElement)

-(void)pushElement:(XMLElement)element;

-(XMLElement)peekElement;

-(XMLElement)popElement;

@end