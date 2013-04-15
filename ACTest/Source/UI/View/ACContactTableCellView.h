//
// Created by Chris Hatton on 05/04/2013.
//

#import <Foundation/Foundation.h>

@class ACContact;

@interface ACContactTableCellView : UITableViewCell

+ (NSString *)reuseIdentifier;

- (id)initWithContact:(ACContact *)contact;

@property (nonatomic,strong) ACContact * contact;

+ (CGFloat)height;

@end