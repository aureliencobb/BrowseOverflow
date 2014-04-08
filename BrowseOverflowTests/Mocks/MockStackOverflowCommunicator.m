//
//  MockStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"

@implementation MockStackOverflowCommunicator {
    BOOL _wasAskedForQuestions;
    BOOL _wasAskedForBody;
}

- (BOOL)wasAskedToFetchQuestions {
    return _wasAskedForQuestions;
}

- (BOOL)wasAskedToFetchBody {
    return _wasAskedForBody;
}

- (void)searchForQuestionsWithTag:(NSString *)tag {
    _wasAskedForQuestions = YES;
}

- (void)downloadQuestionBodyWithID:(NSUInteger)questionID {
    _wasAskedForBody = YES;
}

@end
