//  Copyright (c) 2014 URX. All rights reserved.

#import <Foundation/Foundation.h>
#import "URXSearchResult.h"
#import "URXQuery.h"

#define URX_API_BASE_URL @"http://beta.urx.io/"
#define URX_SEARCH_SDK_VERSION @"0.2"

@interface URXAPIRequestHelper : NSObject

+(NSMutableURLRequest *) requestWithURL:(NSString *)url;
+(NSMutableURLRequest *) searchRequestFromQuery:(URXQuery *)query;
+(NSMutableURLRequest *) resolutionRequestFromSearchResult:(URXSearchResult *)result;
+(NSString *) uriEncode:(NSString *)toEncode;

@end