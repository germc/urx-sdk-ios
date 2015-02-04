//
//  URXRangeableValue.m
//  URXSearch
//
//  Created by James Turner on 1/30/15.
//  Copyright (c) 2015 URX. All rights reserved.
//

#import "URXRangeableValue.h"

@implementation NSDate (URXRangeableValue)

- (NSString *)queryValue {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    return [dateFormatter stringFromDate:self];
}

@end

@implementation NSString (URXRangeableValue)

- (NSString *)queryValue {
    return [self copy];
}

@end