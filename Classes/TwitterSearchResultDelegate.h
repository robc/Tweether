//
//  TwitterSearchResultDelegate.m
//  Tweether
//
//  Created by Rob Caporetto on 15/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

@protocol TwitterSearchResultDelegate<NSObject>
@optional
- (void)searchDidFailWithError:(NSError *)error;
@required
- (void)searchWithTerm:(NSString *)term didCompleteWithResults:(NSArray *)results;
@end

