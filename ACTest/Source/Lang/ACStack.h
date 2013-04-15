//
// Created by Chris Hatton on 06/04/2013.
//

#import <Foundation/Foundation.h>

/**
* Wrapper around NSMutableArray to provide a stack-like interface
*/
@interface ACStack : NSObject

-(void)push:(NSObject*)object;

-(NSObject*)peek;

-(NSObject*)pop;

@end