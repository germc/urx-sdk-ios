//
//  URXSearchResponse.m
//  URXSearch
//
//  Created by James Turner on 10/8/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXSearchResponse.h"
#import "URXSearchResult.h"

@implementation URXSearchResponse

@synthesize entityData=_entityData;
@synthesize results=_results;
@synthesize error=_error;

-(instancetype)initWithEntityData:(NSDictionary *)entityData andCorrelationId:(NSString *)correlationId {
    if (self = [super init]) {
        _entityData = entityData;
        NSArray *resultsJSON = [entityData objectForKey:@"result"];
        NSMutableArray *results = [NSMutableArray array];
        [resultsJSON enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [results addObject:[URXSearchResult searchResultFromEntityData:obj andCorrelationId:correlationId]];
        }];
        _results = [results copy];
    }
    return self;
}

-(instancetype)initWithError:(URXAPIError *)error {
    if (self = [super init]) {
        _error = error;
    }
    return self;
}

@end
