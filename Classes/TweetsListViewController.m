//
//  TweetsListViewController.m
//  Tweether
//
//  Created by Rob Caporetto on 17/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

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
	
	textLabel.text = [self fetchTweetFromTweetsArray:currentTweetPosition].tweet;

	CGSize allowedSize = CGSizeMake(([self.view frame].size.width - 20), 9999);	
	CGSize textSize = [textLabel.text sizeWithFont:textLabel.font
						         constrainedToSize:allowedSize
									lineBreakMode:UILineBreakModeWordWrap];
	
	CGRect labelFrame = CGRectMake(0, 0, textSize.width, textSize.height);
	textLabel.frame = labelFrame;
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
	// [timer release];
	timer = nil;
	
	[textLabel removeFromSuperview];
	// [timer invalidate];

	// TODO: Want to make it so the navigation bar fades in (as the status bar does)
	[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
	[self navigationController].navigationBar.barStyle = UIBarStyleBlackOpaque;
//	[[UIApplication sharedApplication] setStatusBarHidden:NO animated:YES];	
//	[[self navigationController] setNavigationBarHidden:NO animated:NO];

	[UIView commitAnimations];
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
