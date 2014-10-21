//
//  URXPhrase.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXQuery.h"

/** Creates a quoted phrase query from the phrase provided.
 
     Example Code:
         // Create a query from keywords
         URXPhrase *phrase = [URXPhrase phraseWithString:@"pumpkin patch"];
         // Search with the phrase query
         [phrase searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
             // Handle response
         } andFailureHandler:^(URXAPIError *error) {
             // Handle error
         }];
 
 */
@interface URXPhrase : URXQuery

- (instancetype) initWithPhrase:(NSString *)phrase;
+ (instancetype) phraseWithString:(NSString *)string;

@end
