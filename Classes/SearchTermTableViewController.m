//
//  SearchTermTableViewController.m
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SearchTermTableViewController.h"
#import "SearchTermEntryTableViewController.h"
#import "TwitterSearchOperation.h"
#import "SearchTermsSaveDelegate.h"

@implementation SearchTermTableViewController

@synthesize termsArray;
@synthesize networkActivityDelegate;
@synthesize operationQueuingDelegate;

#pragma mark Our custom methods
- (void)showAddSearchTerm:(id)sender
{
	//
	// OFMG. If we add the modalViewController directly, we do not get the NavigationBar!
	// 
	// To ensure the bar appears, we must first instantiate another UINavigationController
	// instance and make it's RootViewController our ModalViewController, then
	// present the UINavigationController instead of the ViewController.
	// 
	// Taken from: http://www.iphonedevsdk.com/forum/iphone-sdk-development/18705-modal-uiviewcontroller-title-not-showing.html
	//
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
	[self updateEditButtonState];
}

- (void)didCancelSearchTermEntry
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)updateEditButtonState
{
	self.navigationItem.leftBarButtonItem.enabled = ([termsArray count] == 0 ? NO : YES);
}

#pragma mark Methods from TwitterSearchResultDelegate
- (void)searchDidFailWithError:(NSError *)error
{
	if ([networkActivityDelegate conformsToProtocol:@protocol(NetworkActivityDelegate)])
		[networkActivityDelegate hideNetworkActivityIndicators];

	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Error Loading"
														 message:[error localizedDescription]
														delegate:nil
											   cancelButtonTitle:@"Ok"
											   otherButtonTitles:nil] autorelease];
	[alertView show];
}

- (void)searchDidCompleteWithResults:(NSArray *)results
{
	if ([networkActivityDelegate conformsToProtocol:@protocol(NetworkActivityDelegate)])
		[networkActivityDelegate hideNetworkActivityIndicators];
	
	// NB: Results doesn't need to be retained here, but only inside
	// our new ViewController - this method is just a proxy for it…
	// 
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[self updateEditButtonState];
}

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
	if ([networkActivityDelegate conformsToProtocol:@protocol(NetworkActivityDelegate)])
		[networkActivityDelegate showNetworkActivityIndicators];

	TwitterSearchOperation *searchOp = [[TwitterSearchOperation alloc] initWithSearchTerm:[termsArray objectAtIndex:indexPath.row]];
	searchOp.delegate = self;
	if ([operationQueuingDelegate conformsToProtocol:@protocol(OperationQueuingDelegate)])
		[operationQueuingDelegate queueOperation:searchOp];
	[searchOp release];	
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		[termsArray removeObjectAtIndex:indexPath.row];
		[self updateEditButtonState];
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

