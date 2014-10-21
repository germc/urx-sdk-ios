//
//  URXAPIError.h
//  URXSearch
//
//  Created by Chris Sell on 9/4/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, URXErrorType) {
    URXNetworkConnectionError,
    URXBadRequestError,
    URXForbiddenError,
    URXQueryNotAcceptableError,
    URXNoSearchResultsError,
    URXDestinationNotFoundError,
    URXLinkGoneError,
    URXRateLimitedError,
    URXServerError,
    URXJSONParsingError,
    URXUnknownError
};

extern NSString * urxAPIErrorMessage(URXErrorType errorType);

/** An object expressing errors in interacting with the URX API.
 */
@interface URXAPIError : NSObject

/** Returns the enumerated type of error.
 
 @return The error type.
 
 */
@property (nonatomic, readonly) URXErrorType errorType;

/** Returns the standard error message for this error type.
 
 @return A description of the error
 
 */
@property (nonatomic, readonly) NSString *errorMessage;

/** Returns the HTTP Request (if any) that may have caused the error.
 
 @return The originating HTTP Request.
 
 */
@property (strong, nonatomic, readonly) NSURLRequest *request;

/** Returns the HTTP Response (if any) that may have caused the error.
 
 @return The corresponding HTTP Response.
 
 */
@property (strong, nonatomic, readonly) NSHTTPURLResponse *response;

/** Returns an NSError that may have occured causing the error. This likely has to do with the HTTP request, but may also originate from parsing bad JSON.
 
 @return The raw NSError.
 
 */
@property (strong, nonatomic, readonly) NSError *error;

/** Returns the data that came back with the HTTP Response.
 
 @return The data returned in the HTTP Response.
 
 */
@property (strong, nonatomic, readonly) NSData *data;

-(instancetype) initWithErrorType:(URXErrorType) errorType request:(NSURLRequest *)request response:(NSHTTPURLResponse *)response error:(NSError *)error data:(NSData *)data;

@end