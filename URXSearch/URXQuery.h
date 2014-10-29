//
//  URXQuery.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URXAPIError.h"

@class URXAnd;
@class URXOr;
@class URXNot;
@class URXSearchResponse;

@interface URXQuery : NSObject

- (URXAnd *) and:(URXQuery *)query;
- (URXOr *) or:(URXQuery *)query;
- (URXNot *) not;
- (URXQuery *) paginateWithLimit:(int)limit andOffset:(int)offset;
- (NSString *) queryString;
- (BOOL) equals:(URXQuery *)query;

/** Makes a search with this query asynchronously with a callback handler for the success case.
 @param NSArray Placement tags provided to this query allows tracking of the performance of queries by tag. This should be an array of NSStrings, any other types in the array will be ignored.
 @param (void (^)(URXSearchResponse *)) The callback to be invoked upon successful completion of the HTTP request.
 @param (void (^)(URXAPIError *)) The callback to be invoked upon failure of the HTTP request.
 @warning This method should be called when the user is to see the search result.
 */
- (void) searchAsynchronouslyWithPlacementTags:(NSArray *)placementTags successHandler:(void (^)(URXSearchResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler;

/** Makes a search with this query synchronously and returns the search response.
 @param NSArray Placement tags provided to this query allows tracking of the performance of queries by tag. This should be an array of NSStrings, any other types in the array will be ignored.
 @return A response object containing the search results and the error (if one occurred).
 @warning This method should be called when the user is to see the search result.
 */
- (URXSearchResponse *) searchSynchronouslyWithPlacementTags:(NSArray *)placementTags;

@end

#import "URXNot.h"
#import "URXSearchResponse.h"