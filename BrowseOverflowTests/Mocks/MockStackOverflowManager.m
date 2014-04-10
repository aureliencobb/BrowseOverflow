//
//  MockStackOverflowManager.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 10/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "MockStackOverflowManager.h"

@implementation MockStackOverflowManager

- (NSInteger)topicFailureCode {
    return _topicFailureErrorCode;
}

- (NSInteger)topicFailureErrorCode {
    return _topicFailureErrorCode;
}

- (NSString *)topicSearchString {
    return _topicSearchString;
}

- (NSString *)answerListString {
    return _answerDownloadString;
}

#pragma mark - delegate methods overrides

- (void)searchingForQuestionsFailedWithError:(NSError *)error {
    _topicFailureErrorCode = error.code;
}

- (void)receivedAnswersJSON:(NSString *)objectNotation {
    _answerDownloadString = objectNotation;
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation {
    _topicSearchString = objectNotation;
}

@end
