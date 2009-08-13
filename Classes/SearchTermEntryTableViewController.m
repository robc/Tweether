//
//  SearchTermEntryTableViewController.m
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SearchTermEntryTableViewController.h"
#import "SearchTermEntryTableViewCell.h"

@implementation SearchTermEntryTableViewController

@synthesize delegate;

#pragma mark SearchTermEntryTableViewController methods
- (IBAction)cancelButtonPressed:(id)sender
{
	if ([delegate respondsToSelector:@selector(didCancelSearchTermEntry)])
		[delegate didCancelSearchTermEntry];
}

- (IBAction)doneButtonPressed:(id)sender
{
	if ([delegate respondsToSelector:@selector(didAddSearchTerm:)])
		[delegate didAddSearchTerm:searchTerm];
}

#pragma mark UIViewController methods
- (void)viewDidLoad
{
    [super viewDidLoad];

	self.navigationItem.title = @"Add Search Term";
	
	UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"	
																		 style:UIBarButtonItemStyleBordered
																		target:self
																		action:@selector(cancelButtonPressed:)];
	self.navigationItem.leftBarButtonItem = cancelButtonItem;
	[cancelButtonItem release];

	UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"	
																		 style:UIBarButtonItemStyleDone
																		target:self
																		action:@selector(doneButtonPressed:)];
	self.navigationItem.rightBarButtonItem = doneButtonItem;
	[doneButtonItem release];
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	searchTerm = textField.text;
	[textField resignFirstResponder];
	return YES;
}

#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"SearchTermEntryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
		NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"SearchTermEntryTableViewCell"
														  owner:self
														options:nil];
		cell = [nibArray objectAtIndex:0];
    }

    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (void)dealloc
{
    [super dealloc];
}

@end

