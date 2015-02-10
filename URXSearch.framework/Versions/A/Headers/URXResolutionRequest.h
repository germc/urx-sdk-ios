//
//  URXResolutionRequest.h
//  URXSearch
//
//  Created by James Turner on 11/24/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URXResolutionResponse.h"
#import "URXAPIError.h"

@interface URXResolutionRequest : NSObject

@property (nonatomic,readonly) NSString *urxResolutionUrl;

-(void) resolveAsynchronouslyWithSuccessHandler:(void (^)(URXResolutionResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler;
-(void) resolveAsynchronouslyWithWebFallbackAndFailureHandler:(void (^)(URXAPIError *))failureHandler;
-(void) resolveAsynchronouslyWithAppStoreFallbackAndFailureHandler:(void (^)(URXAPIError *))failureHandler;

-(URXResolutionResponse *) resolveSynchronously;

+ (instancetype) requestFromUrl:(NSString *)urlString;

-(void) handleResolutionResponse:(NSHTTPURLResponse *)response request:(NSURLRequest *)request data:(NSData *)data error:(NSError *)error successHandler:(void (^)(URXResolutionResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler;

@end
