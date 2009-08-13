//
//  SearchTermTableViewController.m
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SearchTermTableViewController.h"
#import "SearchTermEntryTableViewController.h"

@implementation SearchTermTableViewController

@synthesize termsArray;

#pragma mark Our custom methods
- (void)showAddSearchTerm:(id)sender
{
	// OFMG. If we add the modalViewController directly, we do not get the NavigationBar!
	// In order to ensure the bar appears, we must first instantiate another UINavigationController
	// instance and make it's RootViewController our ModalViewController, then
	// present the UINavigationController instead of the ViewController.
	// See: http://www.iphonedevsdk.com/forum/iphone-sdk-development/18705-modal-uiviewcontroller-title-not-showing.html for more information!
	SearchTermEntryTableViewController *modalViewController = [[SearchTermEntryTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:modalViewController];
	modalViewController.delegate = self;

	[self presentModalViewController:nav animated:YES];
	[nav release];
	[modalViewController release];
}

- (void)didAddSearchTerm:(NSString *)searchTerm;
{
	[termsArray addObject:searchTerm];
	[self dismissModalViewControllerAnimated:YES];
	[self.tableView reloadData];
}

- (void)didCancelSearchTermEntry
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)saveTermsArrayToDisk
{
	;
}

#pragma mark Methods from UIViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

	UIBarButtonItem *addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																					 target:self
																					 action:@selector(showAddSearchTerm:)];
	self.navigationItem.title = @"Search Terms";
	self.navigationItem.rightBarButtonItem = addBarButtonItem;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	[addBarButtonItem release];
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


#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [termsArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [termsArray objectAtIndex:indexPath.row];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		[termsArray removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleDelete;
}

- (void)dealloc
{
	[termsArray release];
    [super dealloc];
}

@end

