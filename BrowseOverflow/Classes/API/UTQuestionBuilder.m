//
//  UTQuestionBuilder.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

NSString * const kItemsKey = @"items";
NSString * const kQuestionIDKey = @"question_id";
NSString * const kCreationDateKey = @"creation_date";
NSString * const kTitleKey = @"title";
NSString * const kScoreKey = @"score";
NSString * const kOwnerKey = @"owner";
NSString * const kBodyKey = @"body";

#import "UTQuestionBuilder.h"

NSString * const QuestionBuilderErrorDomain = @"QuestionBuilderErrorDomain";

@implementation UTQuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)JSON error:(NSError *__autoreleasing *)error {
    id parsedObject = [self parseObjectFromJSON:JSON error:error];//
    if ([parsedObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary * parsedDictionary = (NSDictionary *)parsedObject;
        NSArray * questions = [parsedDictionary objectForKey:kItemsKey];
        NSMutableArray * returnQuestionArray = [[NSMutableArray alloc] initWithCapacity:questions.count];
        for (NSDictionary * questionDictionary in questions) {
            UTQuestion * questionObject = [self buildQuestionFromJSONDictionary:questionDictionary];
            [returnQuestionArray addObject:questionObject];
        }
        if (questions == nil) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderMissingDataError userInfo:nil];
            }
            return nil;
        } else {
            return [NSArray arrayWithArray:returnQuestionArray];
        }
    }
    return nil;
}

#pragma mark - Private methods

- (id)parseObjectFromJSON:(NSString *)JSON error:(NSError *__autoreleasing *)error {
    NSParameterAssert(JSON != nil);
    NSData * jsonData = [JSON dataUsingEncoding:NSUTF8StringEncoding];
    id parsedObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:error];
    if (error != NULL) {
        *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderInvalidJSONError userInfo:nil];
    }
    return parsedObject;
}

- (UTQuestion *)buildQuestionFromJSONDictionary:(NSDictionary *)dictionary {
    UTQuestion * question = [[UTQuestion alloc] init];
    question.questionID = [[dictionary objectForKey:kQuestionIDKey] intValue];
    NSTimeInterval timeIntervalSince1970 = [[dictionary objectForKey:kCreationDateKey] doubleValue];
    question.date = [NSDate dateWithTimeIntervalSince1970:timeIntervalSince1970];
    question.title = [dictionary objectForKey:kTitleKey];
    question.score = [[dictionary objectForKey:kScoreKey] integerValue];
    question.person = [UTPerson personFromJSONDictionary:[dictionary objectForKey:kOwnerKey]];
    question.body = [dictionary objectForKey:kBodyKey];
    return question;
}

@end
