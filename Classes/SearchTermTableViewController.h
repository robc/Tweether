//
//  SearchTermTableViewController.h
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTermEntryDelegate.h"
#import "SearchTermsSaveDelegate.h"
#import "TwitterSearchResultDelegate.h"
#import "NetworkActivityDelegate.h"
#import "OperationQueuingDelegate.h"

@interface SearchTermTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, SearchTermEntryDelegate, TwitterSearchResultDelegate>
{
	NSMutableArray *termsArray;
	id <NetworkActivityDelegate> networkActivityDelegate;
	id <OperationQueuingDelegate> operationQueuingDelegate;
}

@property (nonatomic, retain) NSMutableArray *termsArray;
@property (nonatomic, assign) id <NetworkActivityDelegate> networkActivityDelegate;
@property (nonatomic, assign) id <OperationQueuingDelegate> operationQueuingDelegate;

- (void)showAddSearchTerm:(id)sender;
- (void)updateEditButtonState;

@end
