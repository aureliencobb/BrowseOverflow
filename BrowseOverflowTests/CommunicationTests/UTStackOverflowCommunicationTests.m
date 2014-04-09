//
//  UTStackOverflowCommunicationTests.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 09/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "InspectableStackOverflowCommunicator.h"

@interface UTStackOverflowCommunicationTests : XCTestCase {
    InspectableStackOverflowCommunicator * communicator;
}

@end

@implementation UTStackOverflowCommunicationTests

- (void)setUp {
    [super setUp];
    communicator = [[InspectableStackOverflowCommunicator alloc] init];
}

- (void)tearDown {
    communicator = nil;
    [super tearDown];
}

- (void)testSearchingForQuestionsOnTopicCallsTopicAPI {
    [communicator searchForQuestionsWithTag:@"ios"];
    XCTAssertEqualObjects([[communicator URLToFetch] absoluteString], @"https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=activity&tagged=ios&site=stackoverflow&filter=withbody", @"Use the search api to find questions on a particular tag.");
}

- (void)testFetchingAnswersCallsAPI {
    [communicator downloadAnswersForQuestionID:22968150];
    XCTAssertEqualObjects([[communicator URLToFetch] absoluteString], @"https://api.stackexchange.com/2.2/questions/22968150/answers?order=desc&sort=activity&site=stackoverflow&filter=withbody", @"");
}

- (void)testSearchingForQuestionCreatesURLConnection {
    [communicator searchForQuestionsWithTag:@"ios"];
    XCTAssertNotNil([communicator currentURLConnection], @"There should be an NSURLConnection in flight");
    [communicator cancelAndDiscardURLConnection];
}

@end
