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

/** The base query class for executing searches on the Search endpoint of the URX Search API.
 
 This class provides helper methods for the "and", "or", "not", and pagination operators, as well to allow you to easily string together different segments of queries as you can see in the example below.
 
     Example code:
         NSString *phrase = @"Ellie Goulding";
         NSString *keyword = @"lights";
         URXPhrase *queryPhrase = [URXPhrase phraseWithString:@"ellie goulding"];
         URXTerm *queryTerm = [URXTerm termWithKeywords:@"lights"];
         URXDomain *queryAction = [URXActionFilter listenAction]
         
         [[[queryPhrase and: queryTerm] and: queryAction] searchWithSuccessHandler:^(URXSearchResponse *response) {
             // Handle Search Results
             NSArray *results = response.results;
         
         } AndFailureHandler:^(URXAPIError *error) {
             NSLog(@"an error occured: %@", error.errorMessage);
         }];
 */
@interface URXQuery : NSObject

/** Concatenates two queries with AND.
 @param URXQuery A query to join with this query.
 @return This query and the other query, joined with AND, as a new query.
 */
- (URXAnd *) and:(URXQuery *)query;

/** Concatenates two queries with OR.
 @param URXQuery A query to join with this query.
 @return This query and the other query, joined with OR, as a new query.
 */
- (URXOr *) or:(URXQuery *)query;

/** Negates this query with NOT.
 @return This query, negated with a NOT, as a new query.
 */
- (URXNot *) not;

/** Returns this query with pagination options. Note that pagination options affect the whole query any ignore boolean and conjoining operations.
 @param int The number of search results to return per page (max 10).
 @param int The page offset based on the limit (number of search results to return per page).
 @return This query, with the pagination options, as a new query.
 */
- (URXQuery *) paginateWithLimit:(int)limit andOffset:(int)offset;

/** Returns a string representation of this query.
 @return This query as a query string.
 */
- (NSString *) queryString;

/** Checks for equality with another query.
 @param The other query to compare against.
 @return Whether these two queries are equal.
 */
- (BOOL) equals:(URXQuery *)query;

/** Makes a search with this query asynchronously with a callback handler for the success case.
 @param (void (^)(URXSearchResponse *)) The callback to be invoked upon successful completion of the HTTP request.
 @param (void (^)(URXAPIError *)) The callback to be invoked upon failure of the HTTP request.
 @warning This method should be called when the user is to see the search result.
 */
- (void) searchAsynchronouslyWithSuccessHandler:(void (^)(URXSearchResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler;

/** Makes a search with this query synchronously and returns the search response.
 @return A response object containing the search results and the error (if one occurred).
 @warning This method should be called when the user is to see the search result.
 */
- (URXSearchResponse *) searchSynchronously;

@end

#import "URXNot.h"
#import "URXSearchResponse.h"