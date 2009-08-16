//
//  TweetherAppDelegate.h
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTermsSaveDelegate.h"
#import "NetworkActivityDelegate.h"
#import "OperationQueuingDelegate.h"

@interface TweetherAppDelegate : NSObject <UIApplicationDelegate, SearchTermsSaveDelegate, NetworkActivityDelegate, OperationQueuingDelegate>
{
    UIWindow *window;
	UINavigationController *navigationController;
	NSMutableArray *termsArray;
	NSOperationQueue *operationQueue;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (void)loadSavedTermsFromDisk;

@end

