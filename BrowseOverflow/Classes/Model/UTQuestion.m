//
//  UTQuestion.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTQuestion.h"

@interface UTQuestion()

@property (strong, nonatomic) NSMutableSet * answerSet;

@end

@implementation UTQuestion

- (NSMutableSet *)answerSet {
    if (!_answerSet) {
        _answerSet = [[NSMutableSet alloc] init];
    }
    return _answerSet;
}

- (void)addAnswer:(UTAnswer *)answer {
    [self.answerSet addObject:answer];
}

- (NSArray *)answers {
    return [[self.answerSet allObjects] sortedArrayUsingSelector:@selector(compare:)];
}

@end
