//
//  SearchTermEntryTableViewController.h
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTermEntryDelegate.h"

@interface SearchTermEntryTableViewController : UITableViewController
{
	id <SearchTermEntryDelegate> delegate;
}

@property (nonatomic, assign) id <SearchTermEntryDelegate> delegate;

- (void)cancelButtonPressed:(id)sender;
- (void)doneButtonPressed:(id)sender;

@end
