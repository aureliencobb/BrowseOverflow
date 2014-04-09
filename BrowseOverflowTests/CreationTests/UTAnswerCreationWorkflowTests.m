//
//  UTAnswerCreationWorkflowTests.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 09/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UTStackOverflowManager.h"
#import "MockStackOverflowCommunicator.h"
#import "FakeAnswerBuilder.h"
#import "MockStackOverflowManagerDelegate.h"

const NSInteger questionID = 22960495;

@interface UTAnswerCreationWorkflowTests : XCTestCase {
    UTStackOverflowManager * mgr;
    MockStackOverflowCommunicator * communicator;
    FakeAnswerBuilder * answerBuilder;
    MockStackOverflowManagerDelegate * delegate;
    NSArray * answers;
}

@end

@implementation UTAnswerCreationWorkflowTests

- (void)setUp {
    [super setUp];
    mgr = [[UTStackOverflowManager alloc] init];
    communicator = [[MockStackOverflowCommunicator alloc] init];
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    mgr.delegate = delegate;
    UTAnswer * answer = [[UTAnswer alloc] init];
    answers = @[answer];
    answerBuilder = [[FakeAnswerBuilder alloc] init];
    mgr.answerBuilder = answerBuilder;
}

- (void)tearDown {
    mgr = nil;
    communicator = nil;
    delegate = nil;
    [super tearDown];
}

- (void)testAskingForAnswersMeansRequestingData {
    mgr.communicator = communicator;
    [communicator downloadAnswersForQuestionID:questionID];
    XCTAssertTrue([communicator wasAskedToFetchAnswers], @"The communicator should need to fetch answers");
}

- (void)testAnswerJSONIsPassedToAsnwerBuilder {
    mgr.answerBuilder = answerBuilder;
    [mgr receivedAnswersJSON:@"Some JSON"];
    XCTAssertEqualObjects(@"Some JSON", answerBuilder.JSON, @"The JSON should be passed to the answer builder");
}

- (void)testDelegateReceivedAnswersFromTheManager {
    answerBuilder.answersToReturn = answers;
    [mgr receivedAnswersJSON:@"Some JSON"];
    XCTAssertEqualObjects([delegate receivedAnswers], answers, @"The delegate should be passed the received answers");
}



@end
