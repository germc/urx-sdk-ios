//
//  URXResolutionRequest.m
//  URXSearch
//
//  Created by James Turner on 11/24/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXResolutionRequest.h"
#import "URXAPIRequestHelper.h"

@interface URXResolutionRequest() {
    NSString *_resolutionURL;
}

@end

@implementation URXResolutionRequest

-(void) resolveAsynchronouslyWithSuccessHandler:(void (^)(URXResolutionResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler{
    NSMutableURLRequest *request = [URXAPIRequestHelper requestWithURL:self.urxResolutionUrl];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error)
     {
         [self handleResolutionResponse:(NSHTTPURLResponse *)response request:request data:data error:error successHandler:successHandler andFailureHandler:failureHandler];
     }];
}

-(void) resolveAsynchronouslyWithWebFallbackAndFailureHandler:(void (^)(URXAPIError *))failureHandler {
    [self resolveAsynchronouslyWithSuccessHandler:^(URXResolutionResponse *r) {
        if (![r launchDeeplink]) {
            [r launchInBrowser];
        }
    } andFailureHandler:failureHandler];
}

-(void) resolveAsynchronouslyWithAppStoreFallbackAndFailureHandler:(void (^)(URXAPIError *))failureHandler {
    [self resolveAsynchronouslyWithSuccessHandler:^(URXResolutionResponse *r) {
        if (![r launchDeeplink]) {
            if (![r launchInAppStore]) {
                [r launchInBrowser];
            }
        }
    } andFailureHandler:failureHandler];
}

-(URXResolutionResponse *) resolveSynchronously {
    NSMutableURLRequest *request = [URXAPIRequestHelper requestWithURL:self.urxResolutionUrl];
    
    NSHTTPURLResponse *response;
    NSError *e;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&e];
    
    __block URXResolutionResponse *resolutionResponse;
    
    [self handleResolutionResponse:response request:request data:data error:e successHandler:^(URXResolutionResponse *r) {
        resolutionResponse = r;
    } andFailureHandler:^(URXAPIError *err) {
        resolutionResponse = [URXResolutionResponse resolutionResponseWithError:err];
    }];
    
    return resolutionResponse;
}

-(void) handleResolutionResponse:(NSHTTPURLResponse *)response request:(NSURLRequest *)request data:(NSData *)data error:(NSError *)error successHandler:(void (^)(URXResolutionResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler {
    URXAPIError *(^makeError)(URXErrorType)= ^URXAPIError *(URXErrorType e) {
        return [[URXAPIError alloc] initWithErrorType:e request:request response:response error:error data:data];
    };
    
    //If the HTTP Request gave us an error or we didn't get any data, fail
    if (error != nil || [data length] == 0){
        failureHandler(makeError(URXNetworkConnectionError));
        return;
    }
    
    //Check status codes for errors
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    switch (httpResponse.statusCode) {
        case 200:
            break;
            
        case 400:
            failureHandler(makeError(URXBadRequestError));
            return;
            break;
            
        case 403:
            failureHandler(makeError(URXForbiddenError));
            return;
            break;
            
        case 404:
            failureHandler(makeError(URXDestinationNotFoundError));
            return;
            break;
            
        case 406:
        case 422:
            failureHandler(makeError(URXQueryNotAcceptableError));
            return;
            break;
            
        case 410:
            failureHandler(makeError(URXLinkGoneError));
            return;
            break;
            
        case 429:
            failureHandler(makeError(URXRateLimitedError));
            return;
            break;
            
        case 500:
        case 502:
        case 503:
        case 504:
            failureHandler(makeError(URXServerError));
            return;
            break;
            
        default:
            break;
    }
    
    NSDictionary *responseJSON = [NSJSONSerialization
                                  JSONObjectWithData:data
                                  options:0
                                  error:&error];
    URXResolutionResponse *resolutionResponse = [URXResolutionResponse resolutionResponseWithEntityData:responseJSON];
    successHandler(resolutionResponse);
}

-(NSString *)urxResolutionUrl {
    return [URX_API_BASE_URL stringByAppendingString:[URXAPIRequestHelper uriEncode:_resolutionURL]];
}

- (instancetype) initWithUrlString:(NSString *)url {
    if (self = [super init]) {
        _resolutionURL = url;
    }
    return self;
}

+ (instancetype) requestFromUrl:(NSString *)urlString {
    return [[self alloc] initWithUrlString:urlString];
}

@end
