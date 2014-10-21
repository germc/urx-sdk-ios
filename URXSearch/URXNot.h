//
//  URXNot.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXQuery.h"

/** Negates a queries with NOT. Using the not method of URXQuery is preferred over using this class directly.
 */
@interface URXNot : URXQuery

-(instancetype) initWithQuery:(URXQuery *)query;
+(instancetype) notQuery:(URXQuery *)query;

@end
