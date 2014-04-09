//
//  FakeAnswerBuilder.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 09/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "FakeAnswerBuilder.h"

@implementation FakeAnswerBuilder

- (NSArray *)answersFromJSON:(NSString *)objectNotation error:(NSError *__autoreleasing *)error {
    self.JSON = objectNotation;
    *error = self.errorToSet;
    return self.answersToReturn;
}

@end
