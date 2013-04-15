//
// Created by Chris Hatton on 05/04/2013.
//

#import "ACContactTableCellView.h"
#import "ACContactTableCellContentView.h"
#import "ACContact.h"

static NSString *reuseIdentifier;

@implementation ACContactTableCellView
{
	__strong ACContactTableCellContentView *contactContentView;
}

+(void)initialize
{
	reuseIdentifier = NSStringFromClass([ACContactTableCellView class]);
}

+(NSString*)reuseIdentifier
{
	return reuseIdentifier;
}

-(id)init
{
	self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	if(self)
	{
		contactContentView = [[ACContactTableCellContentView alloc] init];

		self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

		[self.contentView addSubview:contactContentView];
	}
	return self;
}

- (id)initWithContact:(ACContact *)contact
{
	self = [self init];
	if(self)
	{
		[self setContact:contact];
	}
	return self;
}

- (void)setContact:(ACContact *)contact
{
	contactContentView.contact = contact;
}

- (ACContact *)contact
{
	return contactContentView.contact;
}

-(void)layoutSubviews
{
	[super layoutSubviews];

	contactContentView.frame = self.contentView.bounds;
}

+ (CGFloat)height
{
	return [ACContactTableCellContentView height];
}

@end