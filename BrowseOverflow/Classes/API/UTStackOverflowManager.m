//
//  UTStackOverflowManager.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTStackOverflowManager.h"

NSString * StackOverflowManagerError = @"StackOverflowManagerError";
NSString * StackOverflowSearchFailedError = @"StackOverflowSearchFailedError";

@interface UTStackOverflowManager()

@property (strong, nonatomic) UTQuestion * questionNeedingBody;

@end

@implementation UTStackOverflowManager

- (void)setDelegate:(id<UTStackOverflowManagerDelegate>)delegate {
    if (delegate && ![delegate conformsToProtocol:@protocol(UTStackOverflowManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to UTStackOverflowManagerDelegate" userInfo:nil] raise];
    }
    _delegate = delegate;
}

- (void)fetchQuestionsOnTopic:(UTTopic *)topic {
    [self.communicator searchForQuestionsWithTag:topic.tag];
}

- (void)searchingForQuestionsFailedWithError:(NSError *)error {
    NSDictionary * errorInfo = @{NSUnderlyingErrorKey : error};
    [self tellDelegateAboutQuestionSearchError:errorInfo];
}

- (void)receivedQuestionsJSON:(NSString *)objectNotation {
    NSError * error;
    NSArray * questions = [self.questionBuilder questionsFromJSON:objectNotation error:&error];
    if (!questions) {
        NSDictionary * errorInfo;
        if (error) {
            errorInfo = @{NSUnderlyingErrorKey : error};
        }
        [self tellDelegateAboutQuestionSearchError:errorInfo];
    } else {
        [self.delegate didReceiveQuestions:questions];
    }
}

- (void)receivedQuestionBodyJSON:(NSString *)objectNotation {
    [self.questionBuilder fillQuestionBodyFromQuestion:self.questionNeedingBody withJSON:objectNotation error:nil];
}

- (void)fetchBodyForQuestion:(UTQuestion *)question {
    [self.communicator downloadQuestionBodyWithID:question.questionID];
    self.questionBuilder.questionToFill = question;
}

- (void)fetchingQuestionBodyFailedWithError:(NSError *)error {
    NSDictionary * errorInfo;
    if (error != NULL) {
        errorInfo = @{NSUnderlyingErrorKey : error};;
    }
    [self tellDelegateAboutQuestionSearchError:errorInfo];
}

#pragma mark - Private Methods

- (void)tellDelegateAboutQuestionSearchError:(NSDictionary *)errorInfo {
    NSError * reportableError = [NSError errorWithDomain:StackOverflowSearchFailedError code:StackOverflowManagerErrorQuestionSearchCode userInfo:errorInfo];
    [self.delegate fetchingQuestionsFailedWithError:reportableError];
}

@end
