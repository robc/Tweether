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

- (void)updateDoneButtonState
{
	self.navigationItem.rightBarButtonItem.enabled = ([searchTerm length] == 0 ? NO : YES);
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

	searchTerm = @"";
	[self updateDoneButtonState];
}

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
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark UITextFieldDelegate methods
- (void)textFieldDidEndEditing:(UITextField *)textField
{
	searchTerm = textField.text;
	[self updateDoneButtonState];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
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
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//	NSLog(@"didSelectRowAtIndexPath: {%i, %i}", indexPath.section, indexPath.row);
//	SearchTermEntryTableViewCell *cell = (SearchTermEntryTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
//	[cell.searchTermTextField becomeFirstResponder];
//}

- (void)dealloc
{
    [super dealloc];
}

@end

