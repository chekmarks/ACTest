//
// Created by Chris Hatton on 06/04/2013.
//

#import <Foundation/Foundation.h>
#import "ACContact.h"

/**
* This category separates photo-loading functionality from MTContacts primary function as a plain data model class.
*/
@interface ACContact (Photo)

- (void)beginLoadPhoto;

@end