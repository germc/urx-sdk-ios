//
//  URXAPIRequestHelperTests.m
//  URXSearch
//
//  Created by James Turner on 10/28/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "URXAPIRequestHelper.h"
#import "URXAPIKey.h"
#import "URXRawQuery.h"
#import "URXTag.h"

@interface URXAPIRequestHelperTests : XCTestCase

@end

@implementation URXAPIRequestHelperTests

- (void)testRequestWithURL {
    setURXAPIKey(@"API KEY");
    NSMutableURLRequest *request = [URXAPIRequestHelper requestWithURL:@"https://www.example.com"];
    XCTAssert([[[request allHTTPHeaderFields] valueForKey:@"Accept"] isEqualToString:@"application/ld+json"], @"URX API Requests should be requesting data of type application/ld+json with the Accept header");
    // TODO: Maybe make an assertion about the user agent form (regex)? The integration test will fail if the user agent is bad though, so maybe this isn't needed.
    XCTAssertTrue([[[request allHTTPHeaderFields] valueForKey:@"X-API-Key"] isEqualToString:urxAPIKey()], @"URX API Requests should set the X-API-Key header to the API Key provided by the user.");
    setURXAPIKey(nil);
}

- (void)testSearchRequestWithTags {
    setURXAPIKey(@"API KEY");
    
    // Only strings should make it into the header
    NSArray *whatWeAreGoingToPassAsTags = @[@"front page", @[], @"center", @{}];
    NSArray *whatShouldActuallyGoIntoTheHeader = @[@"front page", @"center"];
    
    NSMutableURLRequest *request = [URXAPIRequestHelper searchRequestFromQuery:[[URXTag alloc] initWithQuery:[URXRawQuery queryFromString:@"Joe Montana"] AndTags:whatWeAreGoingToPassAsTags]];
    
    NSArray *tagsFromHeader = [[[request allHTTPHeaderFields] valueForKey:@"X-Tag"] componentsSeparatedByString:@","];
    XCTAssert([tagsFromHeader isEqualToArray:whatShouldActuallyGoIntoTheHeader], @"Search requests taking tags should only include the strings passed into the tags field.");
    
    setURXAPIKey(nil);
}

- (void)testSearchRequestWithoutTags {
    setURXAPIKey(@"API KEY");
    
    NSMutableURLRequest *request = [URXAPIRequestHelper searchRequestFromQuery:[[URXTag alloc] initWithQuery:[URXRawQuery queryFromString:@"Joe Montana"] AndTags:nil]];
    
    XCTAssert([[request allHTTPHeaderFields] valueForKey:@"X-Tag"] == nil, @"If nil tags are passed, the header should not be written.");
    
    setURXAPIKey(nil);
}

- (void)testResolutionRequest {
    setURXAPIKey(@"API KEY");
    
    URXSearchResult *r = [URXSearchResult searchResultFromEntityData:@{@"potentialAction":@{@"target":@{@"urlTemplate":@"a b"}}} andCorrelationId:@"hello"];
    
    NSMutableURLRequest *request = [URXAPIRequestHelper resolutionRequestFromSearchResult:r];
    NSLog(@"%@ : %@", [[request allHTTPHeaderFields] description], request.URL.absoluteString);
    
    NSString *url = request.URL.absoluteString;
    NSString *expectedURL = [NSString stringWithFormat:@"%@a%%20b", URX_API_BASE_URL];
    XCTAssertTrue([url isEqualToString:expectedURL], @"The url grabbed from potentialAction.target.urlTemplate should be uri encoded.");
    
    XCTAssert([[[request allHTTPHeaderFields] valueForKey:@"X-Correlation-Id"] isEqualToString:@"hello"], @"The correlation id should be set on resolution requests.");
    
    setURXAPIKey(nil);
}

@end
