//
// Created by Chris Hatton on 05/04/2013.
//

#import "ACContactViewController.h"
#import "ACContact.h"
#import "ACContactDetailView.h"

@implementation ACContactViewController
{
	__strong ACContact *contact;
}

- (id)initWithContact:(ACContact *)contactIn
{
	self = [self init];
	if(self)
	{
		contact = contactIn;
	}
	return self;
}

-(void)loadView
{
	self.view  = [[ACContactDetailView alloc] initWithContact:contact];
	self.title = [contact fullName];
}

@end