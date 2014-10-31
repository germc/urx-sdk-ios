//
//  URXQueryTests.m
//  URXSearch
//
//  Created by James Turner on 10/16/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "URXQuery.h"
#import "URXTerm.h"

@interface URXQueryTests : XCTestCase

@end

@implementation URXQueryTests

-(void) testPagination {
    NSString *output = [[[URXTerm termWithKeywords:@"magic"] paginateWithLimit:5 andOffset:4] queryString];
    NSLog(@"%@", output);
    XCTAssert([@"magic limit:5 offset:4" isEqualToString:output], @"Pagination helper method didn't give expected output");
}

-(void) testTag {
    NSString *category = @"registrationType";
    NSString *value = @"platinum";
    URXQuery *query = [[URXTerm termWithKeywords:@"some keyword"] withTagCategory:category AndValue:value];
    XCTAssert([@[@"registrationType:platinum"] isEqualToArray:query.tags]);
}

@end
