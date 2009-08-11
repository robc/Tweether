//
//  TweetherAppDelegate.m
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TweetherAppDelegate.h"
#import "SearchTermTableViewController.h"

@implementation TweetherAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	navigationController = [[UINavigationController alloc] init];
	SearchTermTableViewController *searchTermTableViewController = [[SearchTermTableViewController alloc] initWithStyle:UITableViewStylePlain];
	
	NSMutableArray *termsArray = [self loadSavedTermsFromDisk];
	searchTermTableViewController.termsArray = termsArray;
	[termsArray release];
	
    // Override point for customization after application launch
	[navigationController pushViewController:searchTermTableViewController animated:NO];
	[window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}

- (NSMutableArray *)loadSavedTermsFromDisk
{
	return [[NSMutableArray alloc] initWithCapacity:100];
}

- (void)dealloc
{
	[navigationController release];
    [window release];
    [super dealloc];
}
@end
