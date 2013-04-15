//
// Created by Chris Hatton on 06/04/2013.
//

#define ACAssertMainThread()       NSAssert( [[NSThread currentThread] isMainThread], @"Only the main thread is allowed here")
#define ACAssertBackgroundThread() NSAssert(![[NSThread currentThread] isMainThread], @"The main thread is not allowed here" )