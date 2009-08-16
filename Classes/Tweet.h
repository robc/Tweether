//
//  Tweet.h
//  Tweether
//
//  Created by Rob Caporetto on 16/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Tweet : NSObject
{
	NSString *tweet;
	NSString *name;
}

@property (nonatomic, copy) NSString *tweet;
@property (nonatomic, copy) NSString *name;

- (id)initWithTweetDictionary:(NSDictionary *)dictionary;

@end
