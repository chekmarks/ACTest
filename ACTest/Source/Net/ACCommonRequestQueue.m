//
// Created by Chris Hatton on 06/04/2013.
//

#import "ACCommonRequestQueue.h"

NSOperationQueue *COMMON_REQUEST_QUEUE = NULL;

/**
* This function must be called once, during Application initialisation.
*/
void InitializeCommonRequestQueue()
{
	NSCAssert( COMMON_REQUEST_QUEUE==NULL, @"This should be called only once" );

	COMMON_REQUEST_QUEUE = [NSOperationQueue new];
	COMMON_REQUEST_QUEUE.name = @"MTTest_CommonRequestQueue";
}

