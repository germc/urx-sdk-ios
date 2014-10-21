//
//  URXSearchResult.h
//  URXSearch
//
//  Created by James Turner on 9/9/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

/** A wrapper for the search result JSONLD data returned from the search API. This object provides accessors for Schema.org Thing fields (see http://schema.org/Thing) to obtain common data in a consistent way, and also provides methods for resolving (taking the user to) the desired content.
 
    Example Code:
        // Grab an image from the result
        UIImage *resultImage;
        if(searchResult.imageUrl) {
             resultImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:]]];
        }
        // Resolve this search result
        [self resolveAsynchronouslyWithWebFallbackAndFailureHandler:^(URXAPIError *error) {
            NSLog(@"%@", error.errorMessage);
        }];
 */

#import "URXResolutionResponse.h"
#import "URXAPIError.h"

@interface URXSearchResult : NSObject

/** Returns the name property of the Schema.org entity returned as a search result (see http://schema.org/Thing).
 
 @return The entity name.
 
 */
@property (nonatomic,readonly) NSString *name;

/** Returns the image property of the Schema.org entity returned as a search result (see http://schema.org/Thing). In particular, this returns a scalar (singular) value.
 
 @return An image URL from the entity.
 
 */
@property (nonatomic,readonly) NSString *imageUrl;

/** Returns the image property of the Schema.org entity returned as a search result (see http://schema.org/Thing). In particular, this returns a vector (list of values).
 
 @return An array of image URLs from the entity.
 
 */
@property (nonatomic,readonly) NSArray *imagesUrl;

/** Returns the description property of the Schema.org entity returned as a search result (see http://schema.org/Thing).
 
 @return The entity description.
 
 */
@property (nonatomic,readonly) NSString *descriptionText;

/** Returns the call to action text of the entity returned's potential action.
 
 @return The entity's potential action's call to action text.
 
 */
@property (nonatomic,readonly) NSString *callToActionText;

/** Returns the URX Resolution API resource location for this entity's action.
 
 @return The resolution URL.
 
 */
@property (nonatomic,readonly) NSString *urxResolutionUrl;

/** Returns the raw JSONLD entity data.
 
 @return The JSONLD entity data.
 
 */
@property (strong,nonatomic,readonly) NSDictionary *entityData;

/** Creates a new search result from an entity returned by the API
 
 @param NSDictionary The raw JSONLD entity data.
 @return The search result object wrapping the JSONLD entity data.
 
 */
+(instancetype) searchResultFromEntityData:(NSDictionary *)entityData;

/** Resolves the search result asynchronously with a callback handler for the success case.
 @param (void (^)(URXResolutionResponse *)) The callback to be invoked upon successful completion of the HTTP request.
 @param (void (^)(URXAPIError *)) The callback to be invoked upon failure of the HTTP request.
 @warning This method should be called when the user intends to launch the search result.
 */
-(void) resolveAsynchronouslyWithSuccessHandler:(void (^)(URXResolutionResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler;

/** Resolves the search result asynchronously and fallback to the mobile web if there is no app to launch.
 @param (void (^)(URXAPIError *)) The callback to be invoked upon failure of the HTTP request.
 @warning This method should be called when the user intends to launch the search result.
 */
-(void) resolveAsynchronouslyWithWebFallbackAndFailureHandler:(void (^)(URXAPIError *))failureHandler;

/** Resolves the search result asynchronously and fallback to the app store if there is no app to launch.
 @param (void (^)(URXAPIError *)) The callback to be invoked upon failure of the HTTP request.
 @warning This method should be called when the user intends to launch the search result.
 */
-(void) resolveAsynchronouslyWithAppStoreFallbackAndFailureHandler:(void (^)(URXAPIError *))failureHandler;

/** Resolves the search result synchronously and returns the resolution response.
 @return Returns the data from the response object.
 @warning This method should be called when the user intends to launch the search result.
 */
-(URXResolutionResponse *) resolveSynchronously;

@end
