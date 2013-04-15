//
// Created by Chris Hatton on 05/04/2013.
//

#import "ACContact.h"
#import "ACCommonBlocks.h"

#define INVALID_GENDER_FORMAT_REASON @"Must be 'm' or 'f'"

MTContactGender MTContactGenderFromString( NSString* genderString )
{
	if([genderString length]!=1) @throw [NSException exceptionWithName:NSInvalidArgumentException
	                                                            reason:INVALID_GENDER_FORMAT_REASON
		                                                      userInfo:NULL];

	switch( [genderString characterAtIndex:0] )
	{
		case 'm': return MTContactGenderMale;
		case 'f': return MTContactGenderFemale;

		default: @throw [NSException exceptionWithName:NSInvalidArgumentException
		                                        reason:INVALID_GENDER_FORMAT_REASON
			                                  userInfo:NULL];
	}
}

@implementation ACContact

-(id)init
{
	self = [super init];
	if (self)
	{
		NotificationBlock handleLowMemory = ^(NSNotification* notification)
		{
			self.photo = NULL;
		};

		[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidReceiveMemoryWarningNotification
		                                                  object:NULL
			                                               queue:[NSOperationQueue mainQueue]
				                                      usingBlock:handleLowMemory];
	}
	return self;
}

-(NSString *)fullName
{
	return [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
}

-(NSString*)genderString
{
	switch( self.sex )
	{
		case MTContactGenderMale:   return @"Male";
		case MTContactGenderFemale: return @"Female";
		default: return @"Unknown";
	}
}

@end