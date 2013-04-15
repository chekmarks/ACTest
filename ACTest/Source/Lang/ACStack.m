//
// Created by Chris Hatton on 06/04/2013.
//
#import "ACStack.h"

@implementation ACStack
{
	__strong NSMutableArray* stack;
}

-(id)init
{
	self = [super init];
	if(self)
	{
		stack = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)push:(NSObject *)object
{
	[stack addObject:object];
}

- (NSObject *)peek
{
	return [stack lastObject];
}

- (NSObject *)pop
{
	NSObject* object = [stack lastObject];
	if(object)[stack removeLastObject];
	return object;
}

@end