//
//  UTQuestionBuilder.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

NSString * const kItemsKey = @"items";

#import "UTQuestionBuilder.h"

NSString * const QuestionBuilderErrorDomain = @"QuestionBuilderErrorDomain";

@implementation UTQuestionBuilder

- (NSArray *)questionsFromJSON:(NSString *)JSON error:(NSError *__autoreleasing *)error {
    NSParameterAssert(JSON != nil);
    NSData * jsonData = [JSON dataUsingEncoding:NSUTF8StringEncoding];
    NSError * localError;
    id parsedObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&localError];
    if (parsedObject == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderInvalidJSONError userInfo:nil];
        }
        return nil;
    }
    if ([parsedObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary * parsedDictionary = (NSDictionary *)parsedObject;
        NSArray * questions = [parsedDictionary objectForKey:kItemsKey];
        if (questions == nil) {
            if (error != NULL) {
                *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderMissingDataError userInfo:nil];
            }
            return nil;
        }
    }
    return nil;
}

@end
