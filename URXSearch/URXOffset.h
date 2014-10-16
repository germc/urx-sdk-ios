//
//  URXOffset.h
//  URXSearch
//
//  Created by James Turner on 10/15/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URXFilter.h"

@interface URXOffset : URXFilter

-(instancetype) initWithValue:(int) offsetValue;
+(instancetype) offsetWithValue:(int) offsetValue;

@end
