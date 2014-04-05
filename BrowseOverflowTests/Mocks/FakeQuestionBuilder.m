//
//  FakeQuestionBuilder.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "FakeQuestionBuilder.h"
#import "UTQuestion.h"

@implementation FakeQuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)JSON error:(NSError *__autoreleasing *)error {
    self.JSON = JSON;
    *error = self.errorToSet;
    return self.arrayToReturn;
}

@end
