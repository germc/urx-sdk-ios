//
//  URXSearchResponse.h
//  URXSearch
//
//  Created by James Turner on 10/8/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URXAPIError.h"

/** A wrapper for the search response JSONLD data returned from the search API. This object provides an accessor to an array of URXSearchResult objects, the raw JSONLD entity data, and a URXAPIError object if there was an error and this was used in a synchronous fashion.
 */
@interface URXSearchResponse : NSObject

@property (strong, nonatomic, readonly) NSDictionary *entityData;
@property (strong, nonatomic, readonly) NSArray *results;
@property (strong, nonatomic, readonly) URXAPIError *error;

-(instancetype) initWithEntityData:(NSDictionary *)entityData;
-(instancetype) initWithError:(URXAPIError *)error;

@end
