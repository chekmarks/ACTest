//
// Created by Chris Hatton on 06/04/2013.
//

#import <QuartzCore/QuartzCore.h>

#import "ACContactView.h"
#import "ACContact.h"
#import "ACCommonBlocks.h"
#import "ACContact+Photo.h"
#import "ACContactView+Protected.h"
#import "ACAssert.h"

#define PHOTO_KEY @"photo"
#define PHOTO_CORNER_RADIUS 5.0

@interface ACContactView ()

- (void)beginObservingContact;
- (void)endObservingContact;

@end

@implementation ACContactView
{
	__strong UIActivityIndicatorView *imageLoadingIndicatorView;
	__strong UIImageView             *photoImageView;

	BOOL observingContact;
}

-(id)init
{
	self = [super init];
	if(self)
	{
		observingContact = NO;

		photoImageView = [UIImageView new];
		photoImageView.contentMode = UIViewContentModeScaleAspectFill;
		photoImageView.backgroundColor = [UIColor lightGrayColor];
		photoImageView.layer.cornerRadius = PHOTO_CORNER_RADIUS;
		photoImageView.layer.masksToBounds = YES;
		[self addSubview:photoImageView];

		imageLoadingIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[self addSubview:imageLoadingIndicatorView];


		// Listen for low-memory warnings and release this views' reference to the photo if it is off-screen

		NotificationBlock handleLowMemory = ^(NSNotification* notification)
		{
			if(self.window) [photoImageView setImage:NULL];
		};

		[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification
		                                                  object:NULL
			                                               queue:[NSOperationQueue mainQueue]
				                                      usingBlock:handleLowMemory];
	}
	return self;
}

-(id)initWithContact:(ACContact *)contactIn
{
	self = [self init];
	if(self)
	{
		self.contact = contactIn;
	}
	return self;
}

- (void)setContact:(ACContact *)contact
{
	BOOL shouldObserveContact = observingContact;

	[self endObservingContact];

	_contact = contact;

	if(shouldObserveContact) [self beginObservingContact];
}

-(void)layoutSubviews
{
	[super layoutSubviews];

	/**
	 * photoImageView is privately managed, but its layout and corner-radius are controlled by a concrete sub-class.
	 */
	photoImageView.frame              = [self photoImageViewFrame];
	photoImageView.layer.cornerRadius = [self photoImageViewCornerRadius];

	imageLoadingIndicatorView.center = photoImageView.center;
}

/**
* This method must be implemented by a sub-class. It provides a layout for the privately managed photo view.
*/
-(CGRect)photoImageViewFrame
{
	[self doesNotRecognizeSelector:_cmd];
	return CGRectZero;
}

/**
* This method must be implemented by a sub-class. It provides a corner-radius for the privately managed photo view.
*/
-(CGFloat)photoImageViewCornerRadius
{
	[self doesNotRecognizeSelector:_cmd];
	return 0;
}

/**
* Observe for changes in the Contacts photo property
*/
-(void)beginObservingContact
{
	if(_contact && !observingContact)
	{
		observingContact = YES;
		[_contact addObserver:self forKeyPath:PHOTO_KEY options:NSKeyValueObservingOptionNew context:NULL];
	}
}

-(void)endObservingContact
{
	if(_contact && observingContact)
	{
		[_contact removeObserver:self forKeyPath:PHOTO_KEY];
		observingContact = NO;
	}
}

-(void)willMoveToWindow:(UIWindow *)newWindow
{
	if( (self.window==NULL) != (newWindow==NULL) ) // Is this view appearing or disappearing?
	{
		if( newWindow ) // This view is appearing
		{
			[self beginObservingContact];

			[self refreshValues];
		}
		else // This view is disappearing
		{
			[self endObservingContact];
		}
	}
}

-(void)refreshValues
{
	ACAssertMainThread();

	[self setNeedsLayout];

    __strong UIImage* photo = self.contact.photo;

	if( photo ) // If this contacts photo is already loaded, set it to the view now...
	{
		[photoImageView setImage:photo];

		// We may be returning to the screen, where the imageLoadingIndicatorView had previously been started
		[imageLoadingIndicatorView stopAnimating];
	}
	else // ...otherwise, start the loading process.
	{
		[imageLoadingIndicatorView startAnimating];

		[self.contact beginLoadPhoto];
	}
}

#pragma mark Key-Value Observing callback method begins

- (void) observeValueForKeyPath:(NSString*)keyPath
                       ofObject:(id)object
		                 change:(NSDictionary*)change
			            context:(void*)context
{
    if ([keyPath isEqual:PHOTO_KEY])
	{
		__strong UIImage* photo = [change objectForKey:NSKeyValueChangeNewKey];

        __strong Block handleNewPhoto = ^
		{
			[photoImageView setImage:photo];
			[imageLoadingIndicatorView stopAnimating];
		};

		if([[NSThread currentThread] isMainThread])
        {
            handleNewPhoto();
        }
        else
        {
            dispatch_async( dispatch_get_main_queue(), handleNewPhoto );
        }
	}
}

#pragma mark Key-Value Observing callback method ends

@end