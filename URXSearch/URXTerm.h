//
//  URXTerm.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXQuery.h"

@interface URXTerm : URXQuery

- (instancetype) initWithKeywords:(NSString *)keywords;
+ (instancetype) termWithKeywords:(NSString *)keywords;

@end
