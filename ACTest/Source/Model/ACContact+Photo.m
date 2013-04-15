//
// Created by Chris Hatton on 06/04/2013.
//

#import "ACContact+Photo.h"
#import "ACCommonBlocks.h"
#import "ACAssert.h"
#import "ACCommonRequestQueue.h"
#import "UIImage+Blank.h"

@implementation ACContact (Photo)

-(void)beginLoadPhoto
{
    __strong NSURLRequest *loadPhotoRequest = [[NSURLRequest alloc] initWithURL:self.photoUrl];

	CompletionHandler loadPhotoResponseHandler = ^(NSURLResponse *response, NSData *imageData, NSError *error)
	{
		ACAssertBackgroundThread();

		__strong UIImage *newPhoto = NULL;

		if(!error)    newPhoto = [UIImage imageWithData:imageData];

		if(!newPhoto) newPhoto = [UIImage blankImage:CGSizeMake(1,1) withColor:[UIColor whiteColor]];

		dispatch_async( dispatch_get_main_queue(), ^{ self.photo = newPhoto; } );
	};

	[NSURLConnection sendAsynchronousRequest:loadPhotoRequest
	                                   queue:COMMON_REQUEST_QUEUE
		                   completionHandler:loadPhotoResponseHandler];
}

@end