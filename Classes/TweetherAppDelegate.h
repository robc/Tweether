//
//  TweetherAppDelegate.h
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTermsSaveDelegate.h"

@interface TweetherAppDelegate : NSObject <UIApplicationDelegate, SearchTermsSaveDelegate>
{
    UIWindow *window;
	UINavigationController *navigationController;
	NSMutableArray *termsArray;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (void)loadSavedTermsFromDisk;

@end

