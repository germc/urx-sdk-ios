//
//  URXTag.m
//  URXSearch
//
//  Created by James Turner on 10/31/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXTag.h"

@interface URXTag() {
    NSArray *_tags;
}

@property (strong, nonatomic, readonly) URXQuery *query;

@end

@implementation URXTag

@synthesize query=_query;

- (instancetype) initWithQuery:(URXQuery *)query AndTags:(NSArray *)tags {
    if (self = [super init]) {
        if (tags == nil) {
            _tags = @[];
        } else {
            _tags = tags;
        }
        _query = query;
    }
    return self;
}

- (NSArray *)tags {
    NSLog(@"%@", _tags);
    NSLog(@"%@", self.query.tags);
    return [_tags arrayByAddingObjectsFromArray:self.query.tags];
}

- (NSString *)queryString {
    return [self.query queryString];
}

@end
