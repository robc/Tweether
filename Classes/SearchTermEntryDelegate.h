//
//  SearchTermEntryDelegate.m
//  Tweether
//
//  Created by Rob Caporetto on 12/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

@protocol SearchTermEntryDelegate<NSObject>
@required
- (void)didAddSearchTerm:(NSString *)searchTerm;
- (void)didCancelSearchTermEntry;
@end

