//
//  MockStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"

@implementation MockStackOverflowCommunicator

- (void)searchForQuestionsWithTag:(NSString *)tag {
    _wasAskedToFetchQuestions = YES;
}

- (void)downloadAnswersForQuestionID:(NSInteger)questionID {
    _wasAskedToFetchAnswers = YES;
}

@end
