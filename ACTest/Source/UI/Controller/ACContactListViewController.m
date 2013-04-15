//
// Created by Chris Hatton on 05/04/2013.
//

#import "ACContactListViewController.h"
#import "ACContactListDeserializer.h"
#import "ACAssert.h"
#import "ACCommonBlocks.h"
#import "ACCommonRequestQueue.h"
#import "ACContactListTableViewSource.h"
#import "ACContactListXMLElement.h"

@interface ACContactListViewController ()

- (void)beginRequestContactListXML;
- (void)handleContactListReceived:(NSOrderedSet *)contactListIn;

@end

@implementation ACContactListViewController
{
	__strong NSURL *contactListURL;
	__strong ACContactListTableViewSource *tableSource;
	__strong UIActivityIndicatorView *activityIndicator;
	__strong UIAlertView* errorAlert;

	bool firstAppearance;
}

-(id)initWithContactListURL:(NSURL*)contactListURLIn
{
	self = [self init];
	if(self)
	{
		contactListURL  = contactListURLIn;
		_contactList    = NULL;
		firstAppearance = YES;

		self.title = @"Contact List";
	}
	return self;
}

-(void)loadView
{
	[super loadView];

	activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	activityIndicator.hidesWhenStopped = YES;
	[self.view addSubview:activityIndicator];
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];

	activityIndicator.center = self.view.center;

	if( firstAppearance )
	{
		firstAppearance = NO;

		[self beginRequestContactListXML];
	}
}

-(void)beginRequestContactListXML
{
	ACAssertMainThread();

	NSURLRequest *contactListXMLRequest = [[NSURLRequest alloc] initWithURL:contactListURL];

	CompletionHandler contactListXMLResponseHandler = ^(NSURLResponse *response, NSData *xmlData, NSError *error)
	{
		ACAssertBackgroundThread();

		[self handleContactListXMLReceived:xmlData error:error];
	};

	[activityIndicator startAnimating];

	[NSURLConnection sendAsynchronousRequest:contactListXMLRequest
	                                   queue:COMMON_REQUEST_QUEUE
		                   completionHandler:contactListXMLResponseHandler];
}

-(void)handleContactListXMLReceived:(NSData*)xmlData
                              error:(NSError*)error
{
	ACAssertBackgroundThread();

	NSOrderedSet* contactList = NULL;

	if( !error )
	{
		if( xmlData && [xmlData length]>0 )
		{
            __strong ACContactListDeserializer *contactListDeserializer = [ACContactListDeserializer new];

			contactList = [contactListDeserializer contactListFromData:xmlData
			                                                     error:&error];
		}
		else
		{
			error = [NSError errorWithDomain:[[UIApplication sharedApplication] description]
			                            code:200
				                    userInfo:@{ NSLocalizedDescriptionKey : @"No data" }];
		}
	}

	Block handleContactListXMLReceived = ^
	{
		[activityIndicator stopAnimating];

		if( error )
		{
			errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
			                                        message:error.localizedDescription
				                                   delegate:nil
						                  cancelButtonTitle:@"Retry"
										  otherButtonTitles:nil];

			[errorAlert show];
		}
		else
		{
			// Purge items no longer required after de-serialization
			contactListURL = nil;
			XMLElementFromNSStringPurgeCache();

			[self handleContactListReceived:contactList];
		}
	};

	dispatch_async( dispatch_get_main_queue(), handleContactListXMLReceived );
}

-(void)handleContactListReceived:(NSOrderedSet*)contactList
{
	ACAssertMainThread();

	_contactList = contactList;

	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

	tableSource = [[ACContactListTableViewSource alloc] initWithOwner:self];

	_tableView.dataSource = tableSource;
	_tableView.delegate   = tableSource;

	[_tableView reloadData];

	[self.view addSubview:_tableView];

	[UIView transitionWithView:_tableView
	                  duration:1.0
			           options:UIViewAnimationOptionTransitionCrossDissolve
				    animations:NULL
					completion:NULL];
}

#pragma mark UIAlertViewDelegate method implementation begins

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	ACAssertMainThread();
	NSAssert( alertView==errorAlert, NSInternalInconsistencyException );

	[self beginRequestContactListXML];
}

#pragma mark UIAlertViewDelegate method implementation ends

@end