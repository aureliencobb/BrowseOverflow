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

extern NSString * StackOverflowManagerError;
extern NSString * StackOverflowSearchFailedError;

typedef NS_ENUM(NSInteger, StackOverflowManagerErrorCode) {
    StackOverflowManagerErrorQuestionSearchCode
};

@class UTStackOverflowManager;

@protocol UTStackOverflowManagerDelegate <NSObject>

- (void)fetchingQuestionsFailedWithError:(NSError *)error;
- (void)didReceiveQuestions:(NSArray *)questions;

@end

@interface UTStackOverflowManager : NSObject

- (void)fetchQuestionsOnTopic:(UTTopic *)topic;
- (void)fetchBodyForQuestion:(UTQuestion *)question;
- (void)fetchingQuestionBodyFailedWithError:(NSError *)error;
- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;
- (void)receivedQuestionBodyJSON:(NSString *)objectNotation;

@property (weak, nonatomic) id<UTStackOverflowManagerDelegate> delegate;
@property (strong, nonatomic) UTStackOverflowCommunicator * communicator;
@property (strong, nonatomic) UTQuestionBuilder * questionBuilder;

@end
