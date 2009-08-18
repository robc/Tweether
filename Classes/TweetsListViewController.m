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

- (void)setTitle:(NSString *)title
{
	self.navigationItem.title = title;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	
	
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

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
	[tweetsArray release];
    [super dealloc];
}


@end
