//
// Created by Chris Hatton on 06/04/2013.
//
#import <Foundation/Foundation.h>

@class ACContactListViewController;

@interface ACContactListTableViewSource : NSObject <UITableViewDelegate, UITableViewDataSource>

- (id)initWithOwner:(ACContactListViewController *)ownerIn;

@end