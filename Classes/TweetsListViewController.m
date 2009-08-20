//
//  TweetsListViewController.m
//  Tweether
//
//  Created by Rob Caporetto on 17/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/CAAnimation.h>
#import "TweetsListViewController.h"

@implementation TweetsListViewController
@synthesize tweetsArray;

#pragma mark Custom Methods
- (void)setTitle:(NSString *)title
{
	self.navigationItem.title = title;
}

- (void)fetchNextTweetFromTweetsArray:(NSTimer *)timer
{
	currentTweetPosition++;
	if (currentTweetPosition >= [tweetsArray count])
		currentTweetPosition = 0;
	
	[textLabel.layer removeAllAnimations];
	textLabel.text = [[self fetchTweetFromTweetsArray:currentTweetPosition] description];

	CGSize allowedSize = CGSizeMake(([self.view frame].size.width - 10), 9999);	
	CGSize textSize = [textLabel.text sizeWithFont:textLabel.font
						         constrainedToSize:allowedSize
									lineBreakMode:UILineBreakModeWordWrap];
	
	CGFloat x = round((self.view.frame.size.width - textSize.width) / 2);
	CGFloat y = round((self.view.frame.size.height - textSize.height) / 2);
	CGRect labelFrame = CGRectMake(x, y, textSize.width, textSize.height);
	textLabel.frame = labelFrame;
	
	// Just for the usage of the prototype. If we move to a full-scale application,
	// this *will* need to be place in to a custom class so we can provide
	// configurability!
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
	animation.duration = 5.0;
	animation.removedOnCompletion = YES;
	animation.keyPath = @"opacity";
	animation.values = [NSArray arrayWithObjects: 
						[NSNumber numberWithFloat:0.0], 
						[NSNumber numberWithFloat:1.0], 
						[NSNumber numberWithFloat:1.0], 
						[NSNumber numberWithFloat:0.0], nil]; 
	animation.keyTimes = [NSArray arrayWithObjects: 
						  [NSNumber numberWithFloat:0.0],
						  [NSNumber numberWithFloat:0.2],
						  [NSNumber numberWithFloat:0.8],
						  [NSNumber numberWithFloat:1.0], nil]; 

	[textLabel.layer addAnimation:animation	forKey:nil];
}

- (Tweet *)fetchTweetFromTweetsArray:(NSInteger)index
{
	return ((Tweet *)[tweetsArray objectAtIndex:index]);
}

#pragma mark -
#pragma mark UIViewController methods
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	textLabel = [[UILabel alloc] initWithFrame:self.view.frame];
	textLabel.numberOfLines = 0;
	textLabel.font = [UIFont boldSystemFontOfSize:17];
	textLabel.opaque = NO;
	[self.view addSubview:textLabel];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	// TODO: Want to make it so the navigation bar fades out (as the status bar does)
	[UIView beginAnimations:@"fadeToTranslucentBlack" context:nil];
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackTranslucent;
	[self navigationController].navigationBar.barStyle = UIBarStyleBlackTranslucent;
	
//	[[self navigationController] setNavigationBarHidden:YES	animated:NO];
//	[[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
	[UIView commitAnimations];
	
	currentTweetPosition = -1;
	[timer invalidate];
	timer = [NSTimer scheduledTimerWithTimeInterval:5.0
											 target:self
										   selector:@selector(fetchNextTweetFromTweetsArray:)
										   userInfo:nil
											repeats:YES];
	[self fetchNextTweetFromTweetsArray:timer];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

	[timer invalidate];
	timer = nil;
	
	[textLabel removeFromSuperview];

	// TODO: Want to make it so the navigation bar fades in (as the status bar does)
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
	[self navigationController].navigationBar.barStyle = UIBarStyleBlackOpaque;
//	[[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];	
//	[[self navigationController] setNavigationBarHidden:NO animated:NO];

	// [UIView commitAnimations];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc
{
	[textLabel release];
	[tweetsArray release];
    [super dealloc];
}
@end
