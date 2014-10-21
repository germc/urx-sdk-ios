//
//  URXTerm.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXQuery.h"

/** Creates a term/keyword query from the keywords provided.
 
    Example Code:
        // Create a query from keywords
        URXTerm *keywords = [URXTerm termWithKeywords:@"golden gate park"];
        // Search with the keywords query
        [keywords searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
            // Handle response
        } andFailureHandler:^(URXAPIError *error) {
            // Handle error
        }];
 
 */
@interface URXTerm : URXQuery

- (instancetype) initWithKeywords:(NSString *)keywords;
+ (instancetype) termWithKeywords:(NSString *)keywords;

@end
