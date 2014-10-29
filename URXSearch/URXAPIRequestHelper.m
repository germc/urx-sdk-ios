//  Copyright (c) 2014 URX. All rights reserved.

#import <UIKit/UIKit.h>
#import "URXAPIRequestHelper.h"
#import "URXAPIKey.h"

NSString *identifierWithType(NSString *identifier, NSString *type) {
    return [NSString stringWithFormat:@"%@:%@", type, identifier];
};

@implementation URXAPIRequestHelper

+(NSString *)deviceIdentifier {
    // Try to get the Ad Support Idefntifier Manager class
    Class adSupportIdentifierManagerClass = NSClassFromString(@"ASIdentifierManager");
    // If there is no ASIdentifierManager, then return nil
    if(adSupportIdentifierManagerClass == nil) return nil;
    
    // Otherwise, get the IDFA
    // Grab the AdSupportIdentifierManager singleton dynamically
    SEL sharedManagerSel = NSSelectorFromString(@"sharedManager");
    IMP sharedManagerImp = [adSupportIdentifierManagerClass methodForSelector:sharedManagerSel];
    id (*sharedManagerFunction)(id, SEL) = (void *)sharedManagerImp;
    id sharedManagerResult = sharedManagerFunction(adSupportIdentifierManagerClass, sharedManagerSel);
    
    SEL isAdvertisingTrackingEnabledSel = NSSelectorFromString(@"isAdvertisingTrackingEnabled");
    IMP isAdvertisingTrackingEnabledImp = [sharedManagerResult methodForSelector:isAdvertisingTrackingEnabledSel];
    BOOL (*isAdvertisingTrackingEnabledFunction)(id, SEL) = (void *)isAdvertisingTrackingEnabledImp;
    BOOL isAdvertisingTrackingEnabled = isAdvertisingTrackingEnabledFunction(sharedManagerResult, isAdvertisingTrackingEnabledSel);
    
    // If advertising tracking is not enabled, then return nil
    if(isAdvertisingTrackingEnabled == NO) return nil;
    
    // Grab the IDFA dynamically
    SEL advertisingIdentifierSel = NSSelectorFromString(@"advertisingIdentifier");
    IMP advertisingIdentifierImp = [sharedManagerResult methodForSelector:advertisingIdentifierSel];
    id (*advertisingIdentifierFunction)(id, SEL) = (void *)advertisingIdentifierImp;
    NSUUID *advertisingIdentifier = advertisingIdentifierFunction(sharedManagerResult, advertisingIdentifierSel);
    
    return [advertisingIdentifier UUIDString];
}

+(NSString *)userAgentString {
    return [NSString stringWithFormat:@"urx-client/%@ (ios; %@)", URX_SEARCH_SDK_VERSION, [[UIDevice currentDevice] systemVersion]];
}

+(NSMutableURLRequest *) requestWithURL:(NSString *)url {
    NSString *apiKey = urxAPIKey();
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:url]];
    
    // Set HTTP Method type
    [request setHTTPMethod:@"GET"];
    
    // Set Accept Header
    [request setValue:@"application/ld+json"
   forHTTPHeaderField:@"Accept"];

    // Set User-Agent
    [request setValue:[self userAgentString]
   forHTTPHeaderField:@"User-Agent"];
    
    // Set API-Key
    [request setValue:apiKey
   forHTTPHeaderField:@"X-API-Key"];
    
    // Set Device Identifier
    NSString *idfa = [self deviceIdentifier];
    if(idfa != nil) {
        [request addValue:identifierWithType(idfa, @"idfa") forHTTPHeaderField:@"X-Device-Identifier"];
    }
    [request addValue:identifierWithType([[UIDevice currentDevice].identifierForVendor UUIDString], @"idfv") forHTTPHeaderField:@"X-Device-Identifier"];
    
    return request;
}

+(NSMutableURLRequest *) searchRequestFromQuery:(URXQuery *)query {
    NSArray *tags = query.tags;
    NSString *searchUrl = [NSString stringWithFormat:@"%@%@", URX_API_BASE_URL, [self uriEncode:[query queryString]]];
    NSMutableURLRequest *request = [self requestWithURL:searchUrl];
    if(tags != nil) {
        [tags enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if([obj isKindOfClass:[NSString class]]) {
                [request addValue:obj forHTTPHeaderField:@"X-Tag"];
            }
        }];
    }
    return request;
}

+(NSMutableURLRequest *) resolutionRequestFromSearchResult:(URXSearchResult *)result {
    NSMutableURLRequest * request = [self requestWithURL:result.urxResolutionUrl];
    if(result.correlationId != nil) {
        [request addValue:result.correlationId forHTTPHeaderField:@"X-Correlation-Id"];
    }
    [request addValue:[result.resultPosition description] forHTTPHeaderField:@"X-Result-Position"];
    return request;
}

+(NSString *) uriEncode:(NSString *)toEncode {
    return [toEncode stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
}

@end