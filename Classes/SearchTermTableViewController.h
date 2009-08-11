//
//  SearchTermTableViewController.h
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchTermTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
{
	NSMutableArray *termsArray;
}

@property (nonatomic, retain) NSMutableArray *termsArray;

- (void)saveTermsArrayToDisk; // Maybe? Think about it a bit.

@end
