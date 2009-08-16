//
//  TwitterSearchOperation.m
//  Tweether
//
//  Created by Rob Caporetto on 16/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TwitterSearchOperation.h"
#import "CJSONDeserializer.h"
#import "Tweet.h"

#define ResultTweetsCapacity 200

@implementation TwitterSearchOperation

@synthesize delegate;

- (id)initWithSearchTerm:(NSString *)term
{
	if (self = [super init])
	{
		searchTerm = [term copy];
	}
	
	return self;
}

- (void)dealloc
{
	[searchTerm release];
	[super dealloc];
}

- (void)main
{
	NSURL *searchRequestURI = [NSURL URLWithString:[self constructSearchURIWithSearchTerm:searchTerm]];
	NSURLRequest *searchRequest = [NSURLRequest requestWithURL:searchRequestURI];
	NSURLResponse *response = nil;
	NSError *error = nil;
	
	NSData *responseData = [NSURLConnection sendSynchronousRequest:searchRequest returningResponse:&response error:&error];
	
	if ([error code] != 0)
	{
		if ([delegate conformsToProtocol:@protocol(TwitterSearchResultDelegate)])
			[delegate searchDidFailWithError:error];
	}
	else
		[self deserialiseReturnedJSONForSearchResponse:responseData];
}

- (NSString *)constructSearchURIWithSearchTerm:(NSString *)term
{
	// http://search.twitter.com/search.json?q=%23xna (will need to wrap in quotes if necessary)
	// If there's spaces? replace them with a + and wrap in quotes (%22 chars)
	
	NSRange positionOfFirstString = [searchTerm rangeOfString:@" "];
	NSMutableString *urlEncodedSearchTerm = [NSMutableString stringWithString:[searchTerm stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];	
	if (positionOfFirstString.location != NSNotFound)
	{
		[urlEncodedSearchTerm insertString:@"%22" atIndex:0];
		[urlEncodedSearchTerm insertString:@"%22" atIndex:([urlEncodedSearchTerm length] - 1)];		
	}

	return [NSString stringWithFormat:@"http://search.twitter.com/search.json?q=%@", urlEncodedSearchTerm];
}

- (void)deserialiseReturnedJSONForSearchResponse:(NSData *)searchResponse
{
	NSError *error = nil;
	NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:searchResponse error:&error];

	if ([error code] != 0)
	{
		if ([delegate conformsToProtocol:@protocol(TwitterSearchResultDelegate)])
			[delegate searchDidFailWithError:error];
	}
	else
	{
		NSMutableArray *tweetsArray = [[NSMutableArray alloc] initWithCapacity:ResultTweetsCapacity];
		NSArray *resultsArray = [dictionary objectForKey:@"results"];
		Tweet *tweet = nil;
		
		for (NSInteger i = 0; i < [resultsArray count]; i++)
		{
			tweet = [[Tweet alloc] initWithTweetDictionary:[resultsArray objectAtIndex:i]];
			[tweetsArray addObject:tweet];
		}
		
		if ([delegate conformsToProtocol:@protocol(TwitterSearchResultDelegate)])
			[delegate searchDidCompleteWithResults:tweetsArray];
		[tweetsArray release];
	}
}

@end
