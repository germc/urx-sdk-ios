//  Copyright (c) 2014 URX. All rights reserved.

#import "URXSearchResult.h"
#import "NSDictionary+JSONLD.h"
#import "URXAPIRequestHelper.h"
#import "URXResolutionResponse.h"
#import "URXDeeplinkResolutionHelper.h"
#import "URXAPIError.h"

@interface URXSearchResult()

-(instancetype) initWithEntityData:(NSDictionary *)entityData resultPosition:(NSNumber *)resultPosition andCorrelationId:(NSString *)correlationId;

@end

@implementation URXSearchResult

@synthesize entityData = _entityData;
@synthesize correlationId = _correlationId;
@synthesize resultPosition = _resultPosition;

+(instancetype) searchResultFromEntityData:(NSDictionary *)entityData resultPosition:(NSNumber *)resultPosition andCorrelationId:(NSString *)correlationId
{
    return [[self alloc] initWithEntityData:entityData resultPosition:resultPosition andCorrelationId:correlationId];
}

-(instancetype) initWithEntityData:(NSDictionary *)entityData resultPosition:(NSNumber *)resultPosition andCorrelationId:(NSString *)correlationId {
    if (self = [super init]) {
        _entityData = entityData;
        _resultPosition = resultPosition;
        _correlationId = correlationId;
    }
    return self;
}

-(NSString *)name {
    id name = [self.entityData getSingle:@"name"];
    if ([name isKindOfClass:[NSNull class]] || ![name isKindOfClass:[NSString class]]) {
        return nil;
    }
    return (NSString *)name;
}

-(NSString *)imageUrl {
    id image = [self.entityData getSingle:@"image"];
    if ([image isKindOfClass:[NSNull class]]) {
        return nil;
    }
    if ([image isKindOfClass:[NSString class]]) {
        return image;
    }
    if([image isKindOfClass:[NSDictionary class]]) {
        if ([[image getSingle:@"contentUrl"] isKindOfClass:[NSString class]]) {
            return [image getSingle:@"contentUrl"];
        }
        if ([[image getSingle:@"embedUrl"] isKindOfClass:[NSString class]]) {
            return [image getSingle:@"embedUrl"];
        }
        if ([[image getSingle:@"url"] isKindOfClass:[NSString class]]) {
            return [image getSingle:@"url"];
        }
    }
    return nil;
}

-(NSArray *)imagesUrl {
    id images = [self.entityData getMany:@"image"];
    NSMutableArray *imagesToReturn = [NSMutableArray array];
    [images enumerateObjectsUsingBlock:^(id image, NSUInteger idx, BOOL *stop) {
        if ([image isKindOfClass:[NSString class]]) {
            [imagesToReturn addObject:image];
        }
        if([image isKindOfClass:[NSDictionary class]]) {
            if ([[image getSingle:@"contentUrl"] isKindOfClass:[NSString class]]) {
                [imagesToReturn addObject:[image getSingle:@"contentUrl"]];
            }
            if ([[image getSingle:@"embedUrl"] isKindOfClass:[NSString class]]) {
                [imagesToReturn addObject:[image getSingle:@"embedUrl"]];
            }
            if ([[image getSingle:@"url"] isKindOfClass:[NSString class]]) {
                [imagesToReturn addObject:[image getSingle:@"url"]];
            }
        }
    }];
    return [imagesToReturn copy];
}

-(NSString *)descriptionText {
    id description = [self.entityData getSingle:@"description"];
    if ([description isKindOfClass:[NSNull class]] || ![description isKindOfClass:[NSString class]]) {
        return nil;
    }
    return (NSString *)description;
}

-(NSString *)callToActionText {
    id potentialAction = [self.entityData getSingle:@"potentialAction"];
    if (potentialAction == nil || ![potentialAction isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id actionType = [potentialAction getSingle:@"@type"];
    if (potentialAction == nil || ![potentialAction isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSString *actionTypeString = (NSString *)actionType;
    return [actionTypeString substringToIndex:([actionTypeString length] - [@"Action" length])];
}

-(NSString *)urxResolutionUrl {
    return [URX_API_BASE_URL stringByAppendingString:[URXAPIRequestHelper uriEncode:[[[[self.entityData getSingle:@"potentialAction"] getSingle:@"target"] getSingle:@"urlTemplate"] stringByReplacingOccurrencesOfString:@"https://urx.io/" withString:@""]]];
}

-(NSString *)description {
    return [self.entityData description];
}

-(void) resolveAsynchronouslyWithSuccessHandler:(void (^)(URXResolutionResponse *))successHandler andFailureHandler:(void (^)(URXAPIError *))failureHandler{
    NSMutableURLRequest *request = [URXAPIRequestHelper resolutionRequestFromSearchResult:self];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data,
                                               NSError *error)
     {
         [self handleResolutionResponse:(NSHTTPURLResponse *)response request:request data:data error:error successHandler:successHandler andFailureHandler:failureHandler];
     }];
}

-(URXResolutionResponse *) resolveSynchronously {
    NSMutableURLRequest *request = [URXAPIRequestHelper resolutionRequestFromSearchResult:self];
    
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

@end