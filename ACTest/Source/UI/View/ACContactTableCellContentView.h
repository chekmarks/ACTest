//
// Created by Chris Hatton on 06/04/2013.
//

#import <Foundation/Foundation.h>
#import "ACContactView.h"

/**
* Extends ACContactView, to provide suitable style & layout for use as a UITableViewCell's Content view.
* This content view is wrapped by ACContactTableCellView to provide a full UITableCellView implementation.
*/
@interface ACContactTableCellContentView : ACContactView
{
    __strong UILabel
		*nameValueLabel,
		*ageTitleLabel,
		*ageValueLabel,
		*sexTitleLabel,
		*sexValueLabel;
}

+(CGFloat)height;

@end