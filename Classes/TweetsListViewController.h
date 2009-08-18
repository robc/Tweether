//
//  TweetsListViewController.h
//  Tweether
//
//  Created by Rob Caporetto on 17/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetsListViewController : UIViewController
{
	NSTimer *timer;
	NSInteger currentTweetPosition;
	NSArray *tweetsArray;
	UILabel *textLabel;
}

@property (nonatomic, retain) NSArray *tweetsArray;

- (void)setTitle:(NSString *)title;
- (void)fetchNextTweetFromTweetsArray:(NSTimer *)timer;
- (Tweet *)fetchTweetFromTweetsArray:(NSInteger)index;

@end
