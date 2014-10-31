//
//  URXSearchResult.h
//  URXSearch
//
//  Created by James Turner on 9/9/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXResolutionResponse.h"
#import "URXAPIError.h"

@interface URXSearchResult : NSObject

@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readonly) NSString *imageUrl;
@property (nonatomic,readonly) NSArray *imagesUrl;
@property (nonatomic,readonly) NSString *descriptionText;
@property (nonatomic,readonly) NSString *callToActionText;
@property (nonatomic,readonly) NSString *urxResolutionUrl;
@property (strong,nonatomic,readonly) NSDictionary *entityData;

@property (strong, nonatomic, readonly) NSNumber *resultPosition;

/** Returns the id that correlates to the search request.
 
 @return The search request correlation id.
 
 */
@property (strong, nonatomic, readonly) NSString *correlationId;

/** Creates a new search result from an entity returned by the API
 
 @param NSDictionary The raw JSONLD entity data.
 @return The search result object wrapping the JSONLD entity data.
 
 */
+(instancetype) searchResultFromEntityData:(NSDictionary *)entityData resultPosition:(NSNumber *)resultPosition andCorrelationId:(NSString *)correlationId;

-(void) resolveAsynchronouslyWithSuccessHandler:(void (^)(URXResolutionResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler;
-(void) resolveAsynchronouslyWithWebFallbackAndFailureHandler:(void (^)(URXAPIError *))failureHandler;
-(void) resolveAsynchronouslyWithAppStoreFallbackAndFailureHandler:(void (^)(URXAPIError *))failureHandler;

-(URXResolutionResponse *) resolveSynchronously;

@end
