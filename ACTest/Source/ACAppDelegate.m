//
//  ACAppDelegate.m
//
//  Anonymous Company Test
//
//  Created by Chris Hatton on 04/05/13.
//

#import "ACAppDelegate.h"
#import "ACContactListViewController.h"
#import "ACCommonRequestQueue.h"

#define CONTACT_LIST_URL_STRING @"http://chrishatton.org/Data.xml"

@implementation ACAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	__strong UIWindow *window;

    self.window = window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	InitializeCommonRequestQueue();

    __strong NSURL *contactListUrl = [NSURL URLWithString:CONTACT_LIST_URL_STRING];

    __strong ACContactListViewController *contactListViewController =
			[[ACContactListViewController alloc] initWithContactListURL:contactListUrl];

    __strong UINavigationController *navController =
			[[UINavigationController alloc] initWithRootViewController:contactListViewController];

	[window setRootViewController:navController];

	window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];

    return YES;
}

@end