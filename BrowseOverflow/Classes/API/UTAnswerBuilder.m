//
//  UTAnswerBuilder.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 08/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTAnswerBuilder.h"
#import "UTPerson+Creation.h"

NSString * const AnswerBuilderErrorDomain = @"AnswerBuilderErrorDomain";
NSString * const kAnswerItemKey = @"items";
NSString * const kAnswerIsAccepted = @"is_accepted";
NSString * const kAnswerScore = @"score";
NSString * const kAnswerOwner = @"owner";
NSString * const kAnswerBody = @"body";

@implementation UTAnswerBuilder

- (NSArray *)answersFromJSON:(NSString *)objectNotation error:(NSError *__autoreleasing *)error {
    NSParameterAssert(objectNotation != nil);
    NSData * jsonData = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:error];
    if (!jsonObject) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:AnswerBuilderErrorDomain code:AnswerBuilderInvalidJSONError userInfo:nil];
        }
    } else if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary * jsonDict = (NSDictionary *)jsonObject;
        NSArray * answersJSON = [jsonDict objectForKey:kAnswerItemKey];
        if (answersJSON.count) {
            NSMutableArray * answers = [[NSMutableArray alloc] initWithCapacity:answersJSON.count];
            for (NSDictionary * answerDict in answersJSON) {
                [answers addObject:[self answerFromDictionary:answerDict]];
            }
            return [NSArray arrayWithArray:answers];
        } else if (error != NULL) {
            *error = [NSError errorWithDomain:AnswerBuilderErrorDomain code:AnswerBuilderMissingDataError userInfo:nil];
        }
    }
    return nil;
}

- (UTAnswer *)answerFromDictionary:(NSDictionary *)dictionary {
    UTAnswer * answer = [[UTAnswer alloc] init];
    answer.accepted = [[dictionary objectForKey:kAnswerIsAccepted] boolValue];
    answer.score = [[dictionary objectForKey:kAnswerScore] integerValue];
    answer.text = [dictionary objectForKey:kAnswerBody];
    answer.person = [UTPerson personFromJSONDictionary:[dictionary objectForKey:kAnswerOwner]];
    return answer;
}

@end
