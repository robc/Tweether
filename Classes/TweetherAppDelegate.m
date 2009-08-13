//
//  TweetherAppDelegate.m
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TweetherAppDelegate.h"
#import "SearchTermTableViewController.h"

#define TermsFileName @"TweetherSavedSearchTerms.plist"

@implementation TweetherAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	navigationController = [[UINavigationController alloc] init];
	SearchTermTableViewController *searchTermTableViewController = [[SearchTermTableViewController alloc] initWithStyle:UITableViewStylePlain];
	
	[self loadSavedTermsFromDisk];
	searchTermTableViewController.termsArray = termsArray;
	searchTermTableViewController.delegate = self;
	[termsArray release];
	
	[navigationController pushViewController:searchTermTableViewController animated:NO];
	[window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}

- (void)loadSavedTermsFromDisk
{
	termsArray = [[NSMutableArray alloc] initWithCapacity:100];
}

- (void)saveSearchTerms
{
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *savePath = [documentsDirectory stringByAppendingPathComponent:TermsFileName];
	[termsArray writeToFile:savePath atomically:YES];
}

- (void)dealloc
{
	[navigationController release];
    [window release];
    [super dealloc];
}
@end
