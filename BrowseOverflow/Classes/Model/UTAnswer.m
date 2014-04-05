//
//  UTAnswer.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTAnswer.h"

@implementation UTAnswer

- (NSComparisonResult)compare:(UTAnswer *)otherAnswer {
    if (self.accepted && !otherAnswer.accepted) {
        return NSOrderedAscending;
    } else if (!self.accepted && otherAnswer.accepted) {
        return NSOrderedDescending;
    }
    if (self.score > otherAnswer.score) {
        return NSOrderedAscending;
    } else if (self.score < otherAnswer.score) {
        return NSOrderedDescending;
    }
    return NSOrderedSame;
}

@end
