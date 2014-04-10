//
//  UTStackOverflowManager.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTStackOverflowCommunicator.h"
#import "UTTopic.h"
#import "UTQuestionBuilder.h"
#import "UTAnswerBuilder.h"

extern NSString * StackOverflowManagerError;
extern NSString * StackOverflowSearchFailedError;

typedef NS_ENUM(NSInteger, StackOverflowManagerErrorCode) {
    StackOverflowManagerErrorQuestionSearchCode = 3332,
    StackOverflowManagerErrorAnswerDownloadCode = 3333
};

@class UTStackOverflowManager;

@protocol UTStackOverflowManagerDelegate <NSObject>

- (void)fetchingQuestionsFailedWithError:(NSError *)error;
- (void)didReceiveQuestions:(NSArray *)questions;
- (void)didReceiveAnswers:(NSArray *)answers;

@end

@interface UTStackOverflowManager : NSObject <UTStackOverflowCommunicatorDelegate>

- (void)fetchQuestionsOnTopic:(UTTopic *)topic;
- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;
- (void)receivedAnswersJSON:(NSString *)objectNotation;

@property (weak, nonatomic) id<UTStackOverflowManagerDelegate> delegate;
@property (strong, nonatomic) UTStackOverflowCommunicator * communicator;
@property (strong, nonatomic) UTQuestionBuilder * questionBuilder;
@property (strong, nonatomic) UTAnswerBuilder * answerBuilder;

@end
