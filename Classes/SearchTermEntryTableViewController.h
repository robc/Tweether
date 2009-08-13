//
//  SearchTermEntryTableViewController.h
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTermEntryDelegate.h"

@interface SearchTermEntryTableViewController : UITableViewController<UITextFieldDelegate>
{
	NSString *searchTerm;
	id <SearchTermEntryDelegate> delegate;
}

@property (nonatomic, assign) id <SearchTermEntryDelegate> delegate;

- (IBAction)cancelButtonPressed:(id)sender;
- (IBAction)doneButtonPressed:(id)sender;

@end
