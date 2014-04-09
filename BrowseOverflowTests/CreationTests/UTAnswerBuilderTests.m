//
//  UTAnswerBuilderTests.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 09/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UTAnswerBuilder.h"

NSString * const kInvalidJSON = @"Not a JSON object";
NSString * const kNoAnswerJSON = @"{\"noquestions\":true}";
NSString * const kJSONWithOneAnswer = @"{"
    "\"items\": ["
              "{"
                  "\"owner\": {"
                      "\"reputation\": 32246,"
                      "\"user_id\": 1003917,"
                      "\"user_type\": \"registered\","
                      "\"profile_image\": \"http://i.stack.imgur.com/my4Fx.jpg?s=128&g=1\","
                      "\"display_name\": \"Shankar Damodaran\","
                      "\"link\": \"http://stackoverflow.com/users/1003917/shankar-damodaran\""
                  "},"
                  "\"is_accepted\": true,"
                  "\"score\": 5,"
                  "\"last_activity_date\": 1397042450,"
                  "\"last_edit_date\": 1397042450,"
                  "\"creation_date\": 1397041567,"
                  "\"answer_id\": 22960632,"
                  "\"question_id\": 22960495,"
                  "\"body\": \"<p>PHP scripting language.</p>\""
              "}"
        "],"
    "\"has_more\": false,"
    "\"quota_max\": 300,"
    "\"quota_remaining\": 250"
"}";

@interface UTAnswerBuilderTests : XCTestCase {
    UTAnswerBuilder * answerBuilder;
}

@end

@implementation UTAnswerBuilderTests

- (void)setUp {
    [super setUp];
    answerBuilder = [[UTAnswerBuilder alloc] init];
}

- (void)tearDown {
    answerBuilder = nil;
    [super tearDown];
}

- (void)testThatNilJSONThrowsAssertion {
    XCTAssertThrows([answerBuilder answersFromJSON:nil error:NULL], @"Nil JSON should have thrown an assert");
}

- (void)testNilIsReturnedIfJSONIsNotValid {
    XCTAssertNil([answerBuilder answersFromJSON:kInvalidJSON error:NULL], @"Not valid JSON should have return nil");
}

- (void)testErrorIsGeneratedIfJSONIsInvalid {
    NSError * error;
    [answerBuilder answersFromJSON:kInvalidJSON error:&error];
    XCTAssertEqual(error.code, AnswerBuilderInvalidJSONError, @"Invalid JSON should generate error code with invalid json");
}

- (void)testErrorIsGeneratedWhenNoDataPresent {
    NSError * error;
    [answerBuilder answersFromJSON:kNoAnswerJSON error:&error];
    XCTAssertEqual(error.code, AnswerBuilderMissingDataError, @"No Data JSON should generate error code with invalid json");
}

- (void)testAnswerIsGeneratedForValidJSONWithAnswer {
    UTAnswer * answer = [[answerBuilder answersFromJSON:kJSONWithOneAnswer error:nil] firstObject];
    XCTAssertTrue([answer isKindOfClass:[UTAnswer class]], @"A valid JSON with 1 answer should generate an Answer object");
}

- (void)testValidJSONWithNoAnswersReturnsNil {
    XCTAssertNil([answerBuilder answersFromJSON:kNoAnswerJSON error:NULL], @"Valid JSON with no answers should return nil");
}

- (void)testValisAnswerJSONPopulatesAnswerObjectCorrectly {
    UTAnswer * answer = [[answerBuilder answersFromJSON:kJSONWithOneAnswer error:nil] firstObject];
    XCTAssertEqualObjects(@"<p>PHP scripting language.</p>", answer.text, @"The answer should have come with text");
    XCTAssertEqual(YES, answer.accepted, @"The answer should the accepted property set");
    XCTAssertEqual(5, answer.score, @"The answer should have the correct score set");
    UTPerson * person = answer.person;
    XCTAssertEqualObjects(person.name, @"Shankar Damodaran", @"Person name should match data from JSON");
}

@end
