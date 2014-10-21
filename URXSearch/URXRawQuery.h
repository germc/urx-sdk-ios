//
//  URXRawQuery.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXQuery.h"

/** Creates a query from a string. Use at your own risk, as you can form bad queries from arbitrary strings.
 
     Example Code:
     // Create a phrase query for a song title
     URXRawQuery *rawQuer = [URXRawQuery queryFromString:@"beyonce AND action:ListenAction"];
     // Search with raw query
     [rawQuery searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
     // Handle response
     } andFailureHandler:^(URXAPIError *error) {
     // Handle error
     }];
 
 */
@interface URXRawQuery : URXQuery

-(instancetype)initWithQueryString:(NSString *)queryString;
+(instancetype)queryFromString:(NSString *)queryString;

@end
