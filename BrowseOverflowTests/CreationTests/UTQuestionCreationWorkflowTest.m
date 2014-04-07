//
//  UTQuestionCreationTest.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UTStackOverflowManager.h"
#import "MockStackOverflowManagerDelegate.h"
#import "MockStackOverflowCommunicator.h"
#import "FakeQuestionBuilder.h"
#import "UTQuestion.h"

@interface UTQuestionCreationWorkflowTest : XCTestCase {
    UTStackOverflowManager * mgr;
    MockStackOverflowManagerDelegate * delegate;
    NSError * underlyingError;
    NSArray * questionArray;
    FakeQuestionBuilder * questionBuilder;
    UTQuestion * questionToFetch;
    MockStackOverflowCommunicator * communicator;
}

@end

@implementation UTQuestionCreationWorkflowTest

- (void)setUp {
    [super setUp];
    mgr = [[UTStackOverflowManager alloc] init];
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    mgr.delegate = delegate;
    questionToFetch = [[UTQuestion alloc] init];
    questionToFetch.questionID = 1234;
    questionArray = @[questionToFetch];
    questionBuilder = [[FakeQuestionBuilder alloc] init];
    mgr.questionBuilder = questionBuilder;
    underlyingError = [NSError errorWithDomain:@"Test Domain" code:0 userInfo:nil];
    communicator = [[MockStackOverflowCommunicator alloc] init];
}

- (void)tearDown {
    mgr = nil;
    delegate =nil;
    underlyingError = nil;
    questionArray = nil;
    questionToFetch = nil;
    [super tearDown];
}

- (void)testNonConformingObjectsCannotBeDelegate {
    XCTAssertThrows(mgr.delegate = (id<UTStackOverflowManagerDelegate>)[NSNull null], @"NSNull doesnt conform to the UTStackOverflowManagerDelegate protocol and should throw an exception");
}

- (void)testNilAsDelegateIsAcceptable {
    XCTAssertNoThrow(mgr.delegate = nil, @"The UTStackOverflowManager's delegate should be able to be nil");
}

- (void)testThatConformimgObjectsCanBeDelegate {
    XCTAssertNoThrow(mgr.delegate = delegate, @"An object confirming to the UTStackOverflowManagerDelegate protocol should be able to become delegate");
}

- (void)testAskingForQuestionsMeansRequestingData {
    mgr.communicator = communicator;
    UTTopic * topic = [[UTTopic alloc] initWithName:@"iPhone" tag:@"iphone"];
    [mgr fetchQuestionsOnTopic:topic];
    XCTAssertTrue([communicator wasAskedToFetchQuestions], @"The communicator should need to fetch data");
}

- (void)testErrorReturnedToDelegateIsAbstractedFromTheErrorNotifiedByTheCommunicator {
    mgr.delegate = delegate;
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    XCTAssertFalse(underlyingError == [delegate fetchError], @"Error should be at correct level of abtraction");
}

- (void)testErrorReturnedToDelegateDocumentsUnderlyingError {
    mgr.delegate = delegate;
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    XCTAssertEqualObjects(underlyingError, [[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], @"The underlying error should be available to client code");
}

- (void)testQuestionJSONIsPassedToQuestionBuilder {
    mgr.questionBuilder = questionBuilder;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects(questionBuilder.JSON, @"Fake JSON", @"JSON should be sent to the question builder");
    mgr.questionBuilder = nil;
}

- (void)testDelegateNotifiedOfErrorWhenQuestionBuilderFails {
    questionBuilder.arrayToReturn = nil;
    questionBuilder.errorToSet = underlyingError;
    mgr.questionBuilder = questionBuilder;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertNotNil([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], @"The delegate should have been notified about the error");
    mgr.questionBuilder = nil;
}

- (void)testThatNoErrorIsReportedWhenQuestionsReceived {
    questionBuilder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertNil([delegate fetchError], @"No error should be generated on success");
}

- (void)testDelegateReceivedQuestionsDiscoveredByTheManager {
    questionBuilder.arrayToReturn = questionArray;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedQuestions], questionArray, @"The delegate should be passed the received questions");
}

- (void)testThatEmptyArrayPassedToDelegateIsAcceptable {
    questionBuilder.arrayToReturn = [NSArray array];
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedQuestions], [NSArray array], @"It should be acceptable to pass an empty array to the delegate");
}

- (void)testAskingForQuestionBodyMeansRequestingData {
    [mgr fetchBodyForQuestion:questionToFetch];
    XCTAssertTrue([communicator wasAskedToFetchBody], @"The communicator should need to retieve data for the question body");
}

- (void)testDelegateNotifiedOfFailureToFetchQuestion {
    [mgr fetchingQuestionBodyFailedWithError:underlyingError];
    XCTAssertNotNil([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], @"");
}

- (void)testManagerPassesRetrievedQuestionBodyToQuestionBuilder {
    [mgr receivedQuestionBodyJSON:@"Fake JSON"];
    XCTAssertEqualObjects(questionBuilder.JSON, @"Fake JSON", @"Successfully retrieved data should be passed to the builder");
}

@end
