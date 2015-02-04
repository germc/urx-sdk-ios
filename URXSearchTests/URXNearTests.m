//
//  URXNearTests.m
//  URXSearch
//
//  Created by James Turner on 2/4/15.
//  Copyright (c) 2015 URX. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "URXNearFilter.h"

@interface URXNearTests : XCTestCase

@end

@implementation URXNearTests

-(void)testNear
{
    URXNearFilter *nearFilter = [URXNearFilter nearLatitude:1.2 AndLongitude:3.4];
    NSLog(@"%@", [nearFilter queryString]);
    XCTAssertTrue([@"near:1.200000,3.400000" isEqualToString:[nearFilter queryString]], @"Near filter should return a query string designating results near a location");
}

@end
