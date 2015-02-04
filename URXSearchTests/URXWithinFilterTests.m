//
//  URXWithinFilterTests.m
//  URXSearch
//
//  Created by James Turner on 1/29/15.
//  Copyright (c) 2015 URX. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "URXWithinFilter.h"

@interface URXWithinFilterTests : XCTestCase

@end

@implementation URXWithinFilterTests

-(void)testWithin
{
    URXWithinFilter *withinFilter = [URXWithinFilter withinDistance:@"10mi"];
    XCTAssertTrue([@"within:10mi" isEqualToString:[withinFilter queryString]], @"Within filter should return a query string with the given distance");
}


@end
