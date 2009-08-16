//
//  LoadingActivityViewDelegate.m
//  Tweether
//
//  Created by Rob Caporetto on 16/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

@protocol NetworkActivityDelegate<NSObject>
@required
- (void)showNetworkActivityIndicators;
- (void)hideNetworkActivityIndicators;
@end