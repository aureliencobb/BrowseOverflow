//
//  UTStackOverflowCommunicationTests.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 09/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NonNetworkStackOverflowCommunicator.h"
#import "FakeURLResponse.h"
#import "MockStackOverflowManager.h"

@interface UTStackOverflowCommunicator(Tests)
@property (strong, nonatomic) NSMutableData * receivedData;
@property (strong, nonatomic) NSURL * fetchingURL;
@property (strong, nonatomic) NSURLConnection * fetchingConnection;
@end


@interface UTStackOverflowCommunicationTests : XCTestCase {
    NonNetworkStackOverflowCommunicator * nnCommunicator;
    MockStackOverflowManager * manager;
    FakeURLResponse * fourOhFourResponse;
    NSMutableData * receivedData;
}

@end

@implementation UTStackOverflowCommunicationTests

- (void)setUp {
    [super setUp];
    nnCommunicator = [[NonNetworkStackOverflowCommunicator alloc] init];
    manager = [[MockStackOverflowManager alloc] init];
    nnCommunicator.delegate = manager;
    fourOhFourResponse = [[FakeURLResponse alloc] initWithStatusCode:404];
    receivedData = [[NSMutableData alloc] init];
    [receivedData appendData:[@"Received" dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void)tearDown {
    [nnCommunicator cancelAndDiscardURLConnection];
    manager = nil;
    nnCommunicator = nil;
    fourOhFourResponse = nil;
    receivedData = nil;
    [super tearDown];
}

- (void)testSearchingForQuestionsOnTopicCallsTopicAPI {
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    XCTAssertEqualObjects([nnCommunicator.fetchingURL absoluteString], @"https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=activity&tagged=ios&site=stackoverflow&filter=withbody", @"Use the search api to find questions on a particular tag.");
}

- (void)testFetchingAnswersCallsAPI {
    [nnCommunicator downloadAnswersForQuestionID:22968150];
    XCTAssertEqualObjects([nnCommunicator.fetchingURL absoluteString], @"https://api.stackexchange.com/2.2/questions/22968150/answers?order=desc&sort=activity&site=stackoverflow&filter=withbody", @"");
}

- (void)testSearchingForQuestionCreatesURLConnection {
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    XCTAssertNotNil(nnCommunicator.fetchingConnection, @"There should be an NSURLConnection in flight");
    [nnCommunicator cancelAndDiscardURLConnection];
}

- (void)testStartingNewSearchThrowsOutOldConnection {
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    NSURLConnection * firstConnection = nnCommunicator.fetchingConnection;
    [nnCommunicator searchForQuestionsWithTag:@"iphone"];
    XCTAssertFalse([firstConnection isEqual:nnCommunicator.fetchingConnection], @"Making new search should have discarded old connection");
    [nnCommunicator cancelAndDiscardURLConnection];
}

- (void)testReceivingResponseDiscardsExistingData {
    nnCommunicator.receivedData = [[@"Hello" dataUsingEncoding:NSUTF8StringEncoding] mutableCopy];
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    [nnCommunicator connection:nil didReceiveResponse:nil];
    XCTAssertEqual([nnCommunicator.receivedData length], 0, @"Existing data should have been discarded");
}

- (void)testReceivingResponseWith404StatusCodePassesErrorToDelegate {
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    [nnCommunicator connection:nil didReceiveResponse:(NSURLResponse *)fourOhFourResponse];
    XCTAssertEqual([manager topicFailureCode], 404, @"The delegate should have been informed of the error code");
}

- (void)testNoErrorIsReportedOn200StatusCode {
    FakeURLResponse * twoHundredResponse = [[FakeURLResponse alloc] initWithStatusCode:200];
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    [nnCommunicator connection:nil didReceiveResponse:(NSURLResponse *)twoHundredResponse];
    XCTAssertFalse([manager topicFailureCode] == 200, @"The 200 error code should not be communicated back to the delegate");
}

- (void)testConnectionFailingPassesErrorToDelegate {
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    NSError * error = [NSError errorWithDomain:@"Fake Domain" code:12345 userInfo:nil];
    [nnCommunicator connection:nil didFailWithError:error];
    XCTAssertEqual(12345, [manager topicFailureErrorCode], @"This error should be passed to the delegate");
}

- (void)testSuccessfulQuestionSearchPassesDataToDelegate {
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    [nnCommunicator setReceivedData:receivedData];
    [nnCommunicator connectionDidFinishLoading:nil];
    XCTAssertEqualObjects([manager topicSearchString], @"Received", @"The data should be passed to the delegate");
}

- (void)testSuccessfulAnswersPassedToDelegate {
    [nnCommunicator downloadAnswersForQuestionID:12345];
    [nnCommunicator setReceivedData:receivedData];
    [nnCommunicator connectionDidFinishLoading:nil];
    XCTAssertEqualObjects([manager answerListString], @"Received", @"The data should be passed to the delegate");
}

@end
