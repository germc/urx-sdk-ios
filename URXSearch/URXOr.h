//
//  URXOr.h
//  URXSearch
//
//  Created by James Turner on 9/3/14.
//  Copyright (c) 2014 URX. All rights reserved.
//

#import "URXConcatenation.h"

/** Concatenates two queries with OR. Using the or: method of URXQuery is preferred over using this class directly.
 */
@interface URXOr : URXConcatenation

-(instancetype) initWithLeftQuery:(URXQuery *)leftQuery andRightQuery:(URXQuery *)rightQuery;

@end
