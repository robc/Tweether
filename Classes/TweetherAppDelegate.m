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
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
	
	operationQueue = [[NSOperationQueue alloc] init];
	[operationQueue setMaxConcurrentOperationCount:1];
	
	navigationController = [[UINavigationController alloc] init];
	navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	SearchTermTableViewController *searchTermTableViewController = [[SearchTermTableViewController alloc] initWithStyle:UITableViewStylePlain];
	
	[self loadSavedTermsFromDisk];
	searchTermTableViewController.termsArray = termsArray;
	searchTermTableViewController.networkActivityDelegate = self;
	searchTermTableViewController.operationQueuingDelegate = self;
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

- (void)dealloc
{
	[operationQueue release];
	[navigationController release];
    [window release];
    [super dealloc];
}

#pragma mark -
#pragma mark LoadingActivityViewDelegate methods
- (void)showNetworkActivityIndicators
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)hideNetworkActivityIndicators
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

#pragma mark -
#pragma mark SearchTermsSaveDelegate methods
- (void)saveSearchTerms
{
	NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *savePath = [documentsDirectory stringByAppendingPathComponent:TermsFileName];
	[termsArray writeToFile:savePath atomically:YES];
}

#pragma mark -
#pragma mark OperationQueuingDelegate methods
- (void)queueOperation:(NSOperation *)operation
{
	[operationQueue addOperation:operation];
}

@end
