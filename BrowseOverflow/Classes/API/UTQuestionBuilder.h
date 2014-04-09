//
//  UTQuestionBuilder.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTQuestion.h"

typedef NS_ENUM(NSInteger, QuestionBuilderErrorCode) {
    QuestionBuilderInvalidJSONError = 2345,
    QuestionBuilderMissingDataError = 2346
};

extern NSString * const QuestionBuilderErrorDomain;

@interface UTQuestionBuilder : NSObject

@property (copy, nonatomic) NSString * JSON;

- (NSArray *)questionsFromJSON:(NSString *)JSON error:(NSError *__autoreleasing *)error;

@end
