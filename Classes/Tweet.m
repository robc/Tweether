//
//  Tweet.m
//  Tweether
//
//  Created by Rob Caporetto on 16/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

@synthesize tweet;
@synthesize name;

- (id)initWithTweetDictionary:(NSDictionary *)dictionary
{
	if (self = [super init])
	{
		tweet = [[dictionary objectForKey:@"text"] copy];
		name = [[dictionary objectForKey:@"from_user"] copy];
	}
	
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"'%@' by @%@", tweet, name];
}

- (void)dealloc
{
	[tweet release];
	[name release];
	[super dealloc];
}

@end
