//
// Created by Chris Hatton on 06/04/2013.
//
#import <Foundation/Foundation.h>

@class ACContact;

/**
* This is a base-class, managing UI components common to all Contact Views.
* It is intended to be sub-classed to complete the style & layout for specific use-cases.
* Do not instantiate this directly.
*
* This base-class fully encapsulates the Contacts photo view; the behaviour of which is common to all MTContactViews.
* Concrete ACContactView sub-classes must implement the methods declared in ACContactView+Protected.h,
* to provide a layout and style suitable to themselves.
*/
@interface ACContactView : UIView

@property (strong,nonatomic) ACContact * contact;

- (id)initWithContact:(ACContact *)contactIn;

@end