//
//  URXNearFilter.m
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXNearFilter.h"

@implementation URXNearFilter

-(instancetype) initWithLatitude:(double)latitude AndLongitude:(double)longitude
{
    return [super initWithType:@"near" andValue:[NSString stringWithFormat:@"%f,%f", latitude, longitude]];
}

+(instancetype) nearLatitude:(double)latitude AndLongitude:(double)longitude {
    return [[URXNearFilter alloc] initWithLatitude:latitude AndLongitude:longitude];
}

@end