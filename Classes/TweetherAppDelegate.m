//
//  TweetherAppDelegate.m
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TweetherAppDelegate.h"
#import "SearchTermTableViewController.h"
#import "TwitterSearchOperation.h"

#define TermsFileName @"TweetherSavedSearchTerms.plist"
#define MaxNumberOfSearchTerms 256

@implementation TweetherAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
//	TwitterSearchOperation *searchOp = [[TwitterSearchOperation alloc] initWithSearchTerm:@"#xna"];
//	[searchOp main];
	
	navigationController = [[UINavigationController alloc] init];
	SearchTermTableViewController *searchTermTableViewController = [[SearchTermTableViewController alloc] initWithStyle:UITableViewStylePlain];
	
	[self loadSavedTermsFromDisk];
	searchTermTableViewController.termsArray = termsArray;
	[termsArray release];
	
	[navigationController pushViewController:searchTermTableViewController animated:NO];
	[window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[self saveSearchTerms];
}

- (void)loadSavedTermsFromDisk
{
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *loadPath = [documentsDirectory stringByAppendingPathComponent:TermsFileName];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:loadPath])
		termsArray = [[NSMutableArray alloc] initWithContentsOfFile:loadPath];
	else
		termsArray = [[NSMutableArray alloc] initWithCapacity:MaxNumberOfSearchTerms];
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
