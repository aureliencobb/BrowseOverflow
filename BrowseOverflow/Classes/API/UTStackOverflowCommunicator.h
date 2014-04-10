//
//  UTStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const StackOverFlowComminucationErrorDomain;

@protocol UTStackOverflowCommunicatorDelegate <NSObject>

- (void)searchingForQuestionsFailedWithError:(NSError *)error;
- (void)receivedQuestionsJSON:(NSString *)objectNotation;
- (void)dowloadingAnswersFailedWithError:(NSError *)error;
- (void)receivedAnswersJSON:(NSString *)objectNotation;

@end

@interface UTStackOverflowCommunicator : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, weak) id <UTStackOverflowCommunicatorDelegate> delegate;

- (void)searchForQuestionsWithTag:(NSString *)tag;
- (void)downloadAnswersForQuestionID:(NSInteger)questionID;
- (void)cancelAndDiscardURLConnection;

@end
