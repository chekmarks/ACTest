//
// Created by Chris Hatton on 05/04/2013.
//

#import <Foundation/Foundation.h>

@interface ACContactListViewController : UIViewController <UIAlertViewDelegate>

- (id)initWithContactListURL:(NSURL*)contactListURLIn;

- (void)handleContactListXMLReceived:(NSData *)xmlData error:(NSError *)error;

@property (strong,nonatomic,readonly) NSOrderedSet* contactList;
@property (strong,nonatomic,readonly) UITableView*  tableView;

@end