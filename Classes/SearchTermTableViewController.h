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

@interface SearchTermTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, SearchTermEntryDelegate>
{
	NSMutableArray *termsArray;
	id <SearchTermsSaveDelegate> delegate;
}

@property (nonatomic, assign) id <SearchTermsSaveDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *termsArray;

- (void)showAddSearchTerm:(id)sender;
- (void)saveTermsArray;
- (void)updateEditButtonState;

@end
