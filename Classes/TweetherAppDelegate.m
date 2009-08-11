//
//  TweetherAppDelegate.m
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TweetherAppDelegate.h"

@implementation TweetherAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	navigationController = [[UINavigationController alloc] init];
	
	NSArray *termsArray = [self loadSavedTermsFromDisk];
	[termsArray release];
	
    // Override point for customization after application launch
	[window addSubview:navigationController.view];
    [window makeKeyAndVisible];
}


- (NSArray *)loadSavedTermsFromDisk
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
