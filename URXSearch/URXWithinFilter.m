//
//  URXWithinFilter.m
//  URXSearch
//
//  Created by James Turner on 1/28/15.
//  Copyright (c) 2015 URX. All rights reserved.
//

#import "URXWithinFilter.h"
#import "URXFilter.h"

@interface URXWithinFilter()

@property (strong,nonatomic,readonly) NSString *distance;

@end

@implementation URXWithinFilter

@synthesize distance = _distance;

-(instancetype)initWithDistance:(NSString *)distance
{
    self = [super initWithType:@"within" andValue:distance];
    return self;
}

+(instancetype) withinDistance:(NSString *)distance {
    return [[URXWithinFilter alloc] initWithDistance:distance];
}

@end