//
//  URXResolutionResponse.h
//  URXSearch
//
//  Created by James Turner on 9/9/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URXAPIError.h"

/** A wrapper for the search result JSONLD data returned from the resolution API. This object provides methods for launching the app and app store, if available, or at least the web URI.
 
    Example Code:
        // If there is no deeplink available or the device can't launch it, launch in the browser
        if(![resolutionResponse launchDeeplink]) {
            [resolutionResponse launchInBrowser];
        }
 */
@interface URXResolutionResponse : NSObject

/** Returns the raw JSONLD entity data.
 
 @return The JSONLD entity data.
 
 */
@property (strong, nonatomic, readonly) NSDictionary *entityData;

/** If there was an error for this resolution response (on synchronous requests), it will be available here.
 
 @return The API error data.
 
 */
@property (strong, nonatomic, readonly) URXAPIError *error;

/** Returns the deeplink for this content, if available.
 
 @return The deeplink for this content, if available.
 
 */
@property (nonatomic, readonly) NSString *deeplink;

/** Returns the app store link for this content's app, if available.
 
 @return The URL for the app on the app store.
 
 */
@property (nonatomic, readonly) NSString *appStoreUri;

/** Returns the web link for this content.
 
 @return The URL for the content on the web.
 
 */
@property (nonatomic, readonly) NSString *webUri;

/** Returns the name of the site or app that this content is hosted on
 
 @return The URL for the app on the app store.
 
 */
@property (nonatomic, readonly) NSString *appName;

/** Constructs a new resolution response object from JSONLD entity data.
 @param NSDictionary The entity data for the response.
 @return The constructed response object.
 */
+(instancetype) resolutionResponseWithEntityData:(NSDictionary *)entityData;

/** Constructs a new resolution response with the error from the API.
 @param URXAPIError The API error created when trying to resolve a search result.
 @return The constructed response object with the API error.
 */
+(instancetype) resolutionResponseWithError:(URXAPIError *)error;

/** Launch the deeplink, if possible.
 @return Whether or not a deeplink for this resolution response could be launched. This will be NO if there was no deeplink available or if the app is not installed on the user's device.
 */
-(BOOL) launchDeeplink;

/** Launch to the app in the app store, if possible.
 @return Whether or not the app store link for this resolution response could be launched. This will be NO if there was no app store URL provided by the resolution response.
 */
-(BOOL) launchInAppStore;

/** Launch the content in the browser.
 @return Whether or not the web content could be launched. This should always return YES.
 */
-(BOOL) launchInBrowser;

@end
