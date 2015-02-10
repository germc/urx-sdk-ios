//  Copyright (c) 2014 URX. All rights reserved.

#import <Foundation/Foundation.h>
#import "URXSearchResult.h"
#import "URXQuery.h"

#define URX_API_BASE_URL @"https://beta.urx.io/"
#define URX_SEARCH_SDK_VERSION @"0.3"

@interface URXAPIRequestHelper : NSObject

+(NSMutableURLRequest *) requestWithURL:(NSString *)url;
+(NSMutableURLRequest *) searchRequestFromQuery:(URXQuery *)query;
+(NSMutableURLRequest *) resolutionRequestFromSearchResult:(URXSearchResult *)result;
+(NSString *) uriEncode:(NSString *)toEncode;

@end