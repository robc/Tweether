//
//  TwitterSearchOperation.h
//  Tweether
//
//  Created by Rob Caporetto on 16/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TwitterSearchOperation : NSOperation
{
	NSString *searchTerm;
	NSMutableArray *resultTweetsArray;
}

@property (nonatomic, readonly) NSMutableArray *resultTweetsArray;

- (id)initWithSearchTerm:(NSString *)term;
- (NSString *)constructSearchURIWithSearchTerm:(NSString *)term;
- (void)deserialiseReturnedJSONForSearchResponse:(NSData *)searchResponse;

@end
