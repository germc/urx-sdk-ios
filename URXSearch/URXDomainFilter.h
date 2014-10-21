//
//  URXDomainFilter.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXFilter.h"

/** Creates a domain filter query from the paid level domain (PLD) provided.
 
     Example Code:
     // Create a query from keywords
     URXTerm *keywords = [URXTerm termWithKeywords:@"testing 123"];
     // We'll also limit this search to the PLD example.com
     URXDomainFilter *domain = [URXDomainFilter domainWithPLD:@"example.com"];
     // Join the two queries with an AND, and search
     [[keywords and: domain] searchAsynchronouslyWithSuccessHandler:^(URXSearchResponse *response) {
         // Handle response
     } andFailureHandler:^(URXAPIError *error) {
         // Handle error
     }];
 
 */
@interface URXDomainFilter : URXFilter

-(instancetype) initWithDomain:(NSString *)domain;
+(instancetype) domainWithPLD:(NSString *)pld;

@end
