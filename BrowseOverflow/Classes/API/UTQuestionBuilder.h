//
//  UTQuestionBuilder.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, QuestionBuilderErrorCode) {
    QuestionBuilderInvalidJSONError,
    QuestionBuilderMissingDataError
};

extern NSString * const QuestionBuilderErrorDomain;

@interface UTQuestionBuilder : NSObject

- (NSArray *)questionsFromJSON:(NSString *)JSON error:(NSError *__autoreleasing *)error;

@end
