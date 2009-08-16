//
//  TwitterSearchOperation.h
//  Tweether
//
//  Created by Rob Caporetto on 16/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterSearchResultDelegate.h"

@interface TwitterSearchOperation : NSOperation
{
	id <TwitterSearchResultDelegate> delegate;
	NSString *searchTerm;
}

@property (nonatomic, assign) id <TwitterSearchResultDelegate> delegate;

- (id)initWithSearchTerm:(NSString *)term;
- (NSString *)constructSearchURIWithSearchTerm:(NSString *)term;
- (void)deserialiseReturnedJSONForSearchResponse:(NSData *)searchResponse;

@end
