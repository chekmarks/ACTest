//
// Created by Chris Hatton on 06/04/2013.
//

#import "ACContactListTableViewSource.h"
#import "ACContactListViewController.h"
#import "ACContactTableCellView.h"
#import "ACAssert.h"
#import "ACContactViewController.h"
#import "ACContact.h"

@interface ACContactListTableViewSource ()

- (ACContact *)contactForIndexPath:(NSIndexPath *)indexPath;

@end

@implementation ACContactListTableViewSource
{
	__strong ACContactListViewController *owner;
}

-(id)initWithOwner:(ACContactListViewController *)ownerIn
{
	self = [self init];
	if(self)
	{
		owner = ownerIn;
	}
	return self;
}

-(ACContact *)contactForIndexPath:(NSIndexPath*)indexPath
{
	NSUInteger index = (NSUInteger)(indexPath.row);

	NSAssert( index>=0 && index<[owner.contactList count], NSInternalInconsistencyException );

	return owner.contactList[index];
}

#pragma mark UITableViewDelegate method implementation begins

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSAssert( tableView==owner.tableView, NSInternalInconsistencyException );

	return [ACContactTableCellView height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	ACAssertMainThread();
	NSAssert( tableView==owner.tableView, NSInternalInconsistencyException );

    __strong ACContact *contact = [self contactForIndexPath:indexPath];
    __strong ACContactViewController *contactDetailViewController = [[ACContactViewController alloc] initWithContact:contact];

	[owner.navigationController pushViewController:contactDetailViewController animated:YES];

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark UITableViewDelegate method implementation ends


#pragma mark UITableViewDataSource method implementation begins

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	NSAssert( tableView==owner.tableView, NSInternalInconsistencyException );

	return [owner.contactList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSAssert( tableView==owner.tableView, NSInternalInconsistencyException );

    __strong ACContact *contact = [self contactForIndexPath:indexPath];

    __strong ACContactTableCellView *cell = [tableView dequeueReusableCellWithIdentifier:[ACContactTableCellView reuseIdentifier]] ?: [ACContactTableCellView new];

	cell.contact = contact;

	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	NSAssert( tableView==owner.tableView, NSInternalInconsistencyException );

	return 1;
}

#pragma mark UITableViewDataSource method implementation ends

@end