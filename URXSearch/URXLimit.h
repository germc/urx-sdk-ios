//
//  URXLimit.h
//  URXSearch
//
//  Created by James Turner on 10/15/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URXFilter.h"

@interface URXLimit : URXFilter

-(instancetype) initWithValue:(int) limitValue;
+(instancetype) limitWithValue:(int) limitValue;

@end
