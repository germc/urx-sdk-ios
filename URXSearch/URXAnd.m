//
//  URXAnd.m
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXAnd.h"

@implementation URXAnd

-(instancetype) initWithLeftQuery:(URXQuery *)leftQuery andRightQuery:(URXQuery *)rightQuery {
    return [super initWithConcatenationString:@" AND " leftQuery:leftQuery andRightQuery:rightQuery];
}

@end
