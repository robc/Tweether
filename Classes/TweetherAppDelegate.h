//
//  TweetherAppDelegate.h
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetherAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (NSArray *)loadSavedTermsFromDisk;

@end

