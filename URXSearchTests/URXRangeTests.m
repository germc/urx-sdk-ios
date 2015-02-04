//
//  URXRangeTests.m
//  URXSearch
//
//  Created by James Turner on 1/29/15.
//  Copyright (c) 2015 URX. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "URXRange.h"
#import "URXRangeableValue.h"

@interface URXRangeTests : XCTestCase

@end

@implementation URXRangeTests

-(void)testRange
{
    URXRange *range = [URXRange rangeFromStart:[NSDate dateWithTimeIntervalSince1970:0] ToEnd:[NSDate dateWithTimeIntervalSince1970:10000]];
    NSLog(@"%@", [range queryString]);
    XCTAssertTrue([@"1970-01-01T00:00:00Z...1970-01-01T02:46:40Z" isEqualToString:[range queryString]], @"Should create a date range from Unix epoch to unix epoch + 10000.");
}


@end
