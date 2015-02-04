//
//  URXRange.m
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXRange.h"

@interface URXRange()

@property (nonatomic, strong, readonly) id<URXRangeableValue> start;
@property (nonatomic, strong, readonly) id<URXRangeableValue> end;

@end

@implementation URXRange

@synthesize start = _start;
@synthesize end = _end;

- (instancetype) initWithStart:(id<URXRangeableValue>)start AndEnd:(id<URXRangeableValue>)end
{
    if (self = [super init]) {
        _start = start;
        _end = end;
    }
    return self;
}

- (NSString *)queryString
{
    if (self.start == nil && self.end == nil) {
        return @"";
    }
    NSString *startQueryString;
    NSString *endQueryString;
    if (self.start == nil) {
        startQueryString = @"";
    } else {
        startQueryString = [self.start queryValue];
    }
    if (self.end == nil) {
        endQueryString = @"";
    } else {
        endQueryString = [self.end queryValue];
    }
    return [NSString stringWithFormat:@"%@...%@", startQueryString, endQueryString];
}

+ (instancetype) rangeFromStart:(id<URXRangeableValue>)start ToEnd:(id<URXRangeableValue>)end {
    return [[URXRange alloc] initWithStart:start AndEnd:end];
}

@end