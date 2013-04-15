//
// Created by Chris Hatton on 06/04/2013.
//

#import <QuartzCore/QuartzCore.h>

#import "ACContactDetailView.h"
#import "ACContact.h"
#import "ACGraphics.h"
#import "ACContactView+Protected.h"
#import "ACAssert.h"

#define PADDING 8.0

@interface ACContactDetailView ()

- (CGFloat)contentWidth;

@end

@implementation ACContactDetailView
{
	__strong UITextView *noteTextField;
}

-(id)init
{
	self = [super init];
	if(self)
	{
		noteTextField = [UITextView new];
		noteTextField.backgroundColor = [UIColor darkGrayColor];
		noteTextField.textColor = [UIColor whiteColor];
		noteTextField.font = [UIFont boldSystemFontOfSize:16.0];
		noteTextField.layer.cornerRadius = PADDING;
		noteTextField.editable = NO;
		[self addSubview:noteTextField];
	}
	return self;
}

/**
* Provide a common content-width calculation for layoutSubviews and photoImageViewFrame.
*/
-(CGFloat)contentWidth
{
	return self.superview.frame.size.width - (2 * PADDING);
}

-(void)layoutSubviews
{
	[super layoutSubviews];

	CGRect photoImageViewFrame = [self photoImageViewFrame];

	float
		photoBottom = photoImageViewFrame.origin.y + photoImageViewFrame.size.height,
		notesTop    = photoBottom + PADDING,
	    notesHeight = self.superview.frame.size.height - notesTop - PADDING;

	CGSize  notesTextFieldSize     = CGSizeMake( [self contentWidth], notesHeight );
	CGPoint notesTextFieldLocation = CGPointMake( PADDING, notesTop );

	noteTextField.frame = ACRectMake( notesTextFieldLocation, notesTextFieldSize );
}

- (void)refreshValues
{
	ACAssertMainThread();

	[super refreshValues];

	noteTextField.text = self.contact.notes;
}


#pragma mark Implementation of protected method stubs begin

- (CGRect)photoImageViewFrame
{
	CGFloat photoSize = [self contentWidth];

	CGSize  photoImageViewSize     = CGSizeMake( photoSize, photoSize );
	CGPoint photoImageViewLocation = CGPointMake( PADDING, PADDING );

	return ACRectMake( photoImageViewLocation, photoImageViewSize );
}

- (CGFloat)photoImageViewCornerRadius
{
	return PADDING;
}

#pragma mark Implementation of protected method stubs end

@end