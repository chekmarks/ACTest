//
// Created by Chris Hatton on 06/04/2013.
//

#import "ACContactTableCellContentView.h"
#import "ACGraphics.h"
#import "ACContact.h"
#import "ACContactView+Protected.h"
#import "ACAssert.h"

#define PHOTO_SIZE     54.0
#define PADDING        6.0
#define INFO_FONT_SIZE 16.0
#define NAME_FONT_SIZE 21.0

@implementation ACContactTableCellContentView
{
}

-(id)init
{
	self = [super init];
	if(self)
	{
		nameValueLabel = [UILabel new];
		nameValueLabel.backgroundColor = [UIColor clearColor];
		nameValueLabel.textColor = [UIColor darkTextColor];
		nameValueLabel.font = [UIFont boldSystemFontOfSize:NAME_FONT_SIZE];
		[self addSubview:nameValueLabel];

		ageTitleLabel = [UILabel new];
		ageTitleLabel.text = @"Age";
		ageTitleLabel.backgroundColor = [UIColor clearColor];
		ageTitleLabel.textColor = [UIColor grayColor];
		ageTitleLabel.font = [UIFont boldSystemFontOfSize:INFO_FONT_SIZE];
        [self addSubview:ageTitleLabel];

		ageValueLabel  = [UILabel new];
		ageValueLabel.backgroundColor = [UIColor clearColor];
		ageValueLabel.textColor = [UIColor darkTextColor];
		ageValueLabel.font = [UIFont systemFontOfSize:INFO_FONT_SIZE];
		[self addSubview:ageValueLabel];

		sexTitleLabel  = [UILabel new];
		sexTitleLabel.text = @"Sex";
		sexTitleLabel.backgroundColor = [UIColor clearColor];
		sexTitleLabel.textColor = [UIColor grayColor];
		sexTitleLabel.font = [UIFont boldSystemFontOfSize:INFO_FONT_SIZE];
		[self addSubview:sexTitleLabel];

		sexValueLabel  = [UILabel new];
		sexValueLabel.backgroundColor = [UIColor clearColor];
		sexValueLabel.textColor = [UIColor darkTextColor];
		sexValueLabel.font = [UIFont systemFontOfSize:INFO_FONT_SIZE];
		[self addSubview:sexValueLabel];
	}
	return self;
}

-(void)layoutSubviews
{
	[super layoutSubviews];

	CGRect photoFrame = [self photoImageViewFrame];

	CGSize
		nameValueLabelSize  = [nameValueLabel sizeThatFits:CGSizeZero],
		ageTitleLabelSize   = [ageTitleLabel sizeThatFits:CGSizeZero],
		ageValueLabelSize   = [ageValueLabel  sizeThatFits:CGSizeZero],
		sexTitleLabelSize   = [sexTitleLabel  sizeThatFits:CGSizeZero],
		sexValueLabelSize   = [sexValueLabel  sizeThatFits:CGSizeZero];

	float
		labelAreaLeft    = photoFrame.origin.x + photoFrame.size.width + PADDING,
		labelAreaWidth   = self.superview.frame.size.width - labelAreaLeft,
		labelAreaMidX    = labelAreaLeft + (labelAreaWidth / 2),
		labelAreaHeight  = photoFrame.size.height,
		labelAreaTop     = photoFrame.origin.y,
		upperLineCenterY = (labelAreaHeight * 0.25 ) + labelAreaTop,
		lowerLineCenterY = (labelAreaHeight * 0.75 ) + labelAreaTop,
		lowerLineHeight  = fmaxf(ageTitleLabelSize.height, fmaxf(ageValueLabelSize.height, fmaxf(sexTitleLabelSize.height, sexValueLabelSize.height)));

	CGPoint
		nameValueLabelLocation  = CGPointMake( labelAreaLeft, upperLineCenterY - (nameValueLabelSize.height/2) ),
		ageTitleLabelLocation   = CGPointMake( labelAreaLeft, lowerLineCenterY - (lowerLineHeight/2)),
		ageValueLabelLocation   = CGPointMake( ageTitleLabelLocation.x + ageTitleLabelSize.width + PADDING, lowerLineCenterY - (lowerLineHeight/2)),
		sexTitleLabelLocation   = CGPointMake( labelAreaMidX, lowerLineCenterY - (lowerLineHeight/2)),
		sexValueLabelLocation   = CGPointMake( sexTitleLabelLocation.x + sexTitleLabelSize.width + PADDING, lowerLineCenterY - (lowerLineHeight/2));

	nameValueLabel.frame = ACAliasRect( ACRectMake( nameValueLabelLocation, nameValueLabelSize) );
	ageTitleLabel.frame  = ACAliasRect( ACRectMake( ageTitleLabelLocation,  ageTitleLabelSize) );
	ageValueLabel.frame  = ACAliasRect( ACRectMake( ageValueLabelLocation,  ageValueLabelSize) );
	sexTitleLabel.frame  = ACAliasRect( ACRectMake( sexTitleLabelLocation,  sexTitleLabelSize) );
	sexValueLabel.frame  = ACAliasRect( ACRectMake( sexValueLabelLocation,  sexValueLabelSize) );
}

- (void)setContact:(ACContact *)contact
{
    ACAssertMainThread();

	[super setContact:contact];

    if(self.window) [self refreshValues];
}

-(void)refreshValues
{
	ACAssertMainThread();

	[super refreshValues];

	nameValueLabel.text = [self.contact fullName];
	ageValueLabel.text  = [NSString stringWithFormat:@"%d", self.contact.age];
	sexValueLabel.text  = [self.contact genderString];
}

+ (CGFloat)height
{
	return PHOTO_SIZE + (2*PADDING);
}

#pragma mark Implementation of protected method stubs begin

- (CGRect)photoImageViewFrame
{
	CGSize photoImageViewSize = CGSizeMake( PHOTO_SIZE, PHOTO_SIZE );

	CGPoint photoImageViewLocation = CGPointMake( PADDING, PADDING );

	return ACRectMake( photoImageViewLocation, photoImageViewSize );
}

- (CGFloat)photoImageViewCornerRadius
{
	return PADDING;
}

#pragma mark Implementation of protected method stubs end

@end