//
//  TweetsListViewController.h
//  Tweether
//
//  Created by Rob Caporetto on 17/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TweetsListViewController : UIViewController
{
	NSArray *tweetsArray;
}

@property (nonatomic, retain) NSArray *tweetsArray;

- (void)setTitle:(NSString *)title;

@end
