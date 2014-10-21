//
//  URXGroup.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXQuery.h"

/** Groups an array of querys with parentheses.
 
    Example Code:
    // Create a phrase query for a song title
    URXPhrase *phrase = [URXPhrase phraseWithString:@"ode to joy"];
    // We'll also limit this search to ListenAction to provide our users with some music
    URXActionFilter *listen = [URXActionFilter listenAction];
    // If we group together these queries, we can compose it with other queries to form some complex behavior
    URXGroup *listenToOdeToJoy = [URXGroup groupQueries:@[phrase, listen]];
    URXTerm *beethoven = [URXTerm termWithKeywords:@"beethoven"];
 
    // Join the two queries with an AND, and search
    [[listenToOdeToJoy and: beethoven] searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
        // Handle response
    } andFailureHandler:^(URXAPIError *error) {
        // Handle error
    }];
 
 */
@interface URXGroup : URXQuery

- (instancetype) initWithQueries:(NSArray *)queries;
+ (instancetype) groupQueries:(NSArray *)queries;

@end
