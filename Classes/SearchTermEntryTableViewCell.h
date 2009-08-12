//
//  SearchTermEntryTableViewCell.h
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchTermEntryTableViewCell : UITableViewCell
{
	UITextField *searchTermTextField;
}

@property (nonatomic, retain) IBOutlet UITextField *searchTermTextField;

@end
