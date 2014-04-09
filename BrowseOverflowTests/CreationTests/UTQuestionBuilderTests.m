//
//  UTQuestionBuilderTests.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UTQuestionBuilder.h"
#import "UTQuestion.h"

NSString * const kJSONWithOneQuestion = @"{"
    "\"items\": ["
              "{"
                  "\"tags\": ["
                           "\"ios\","
                           "\"iphone\","
                           "\"objective-c\","
                           "\"uitableview\","
                           "\"uitableviewcell\""
                           "],"
                  "\"owner\": {"
                      "\"reputation\": 17,"
                      "\"user_id\": 1380903,"
                      "\"user_type\": \"registered\","
                      "\"profile_image\": \"https://www.gravatar.com/avatar/67bfd68f04be6ae2b6fd459f94e3c3e1?s=128&d=identicon&r=PG\","
                      "\"display_name\": \"Tylr\","
                      "\"link\": \"http://stackoverflow.com/users/1380903/tylr\""
                  "},"
                  "\"is_answered\": false,"
                  "\"view_count\": 1,"
                  "\"answer_count\": 0,"
                  "\"score\": 0,"
                  "\"last_activity_date\": 1396804029,"
                  "\"creation_date\": 1396804029,"
                  "\"question_id\": 22897182,"
                  "\"link\": \"http://stackoverflow.com/questions/22897182/how-to-pass-the-in-place-edited-content-back-to-the-previous-tableview-controlle\","
                  "\"title\": \"How to pass the in-place edited content back to the previous tableview controller (update the model)\""
              "}"
        "]"
"}";
NSString * const kNoJSON = @"Not a JSON object";
NSString * const kNoQuestionJSON = @"{\"noquestions\":true}";
NSString * const kEmptyQuestionJSON = @"{\"items\":[{}]}";
NSString * const kValidBodyJSON = @"{\"body\":\"<p>This is some text in the body. <code>[Class message];</code></p>\"}";

@interface UTQuestionBuilderTests : XCTestCase {
    UTQuestionBuilder * questionBuilder;
    UTQuestion * question;
}

@end

@implementation UTQuestionBuilderTests

- (void)setUp {
    [super setUp];
    questionBuilder = [[UTQuestionBuilder alloc] init];
    question = [[questionBuilder questionsFromJSON:kJSONWithOneQuestion error:NULL] firstObject];
}

- (void)tearDown {
    questionBuilder = nil;
    [super tearDown];
}

- (void)testThatNilIsNotAnAcceptableParameter {
    XCTAssertThrows([questionBuilder questionsFromJSON:nil error:NULL], @"Lack of data should have been handled elsewhere");
}

- (void)testNilIsReturnedWhenStringIdNotJSON {
    XCTAssertNil([questionBuilder questionsFromJSON:kNoJSON error:NULL], @"This parameter should not be parsable");
}

- (void)testErrorIsSetWhenStringIsNotJSON {
    NSError * error;
    [questionBuilder questionsFromJSON:kNoJSON error:&error];
    XCTAssertNotNil(error, @"There should be an error with invalid JSON");
}

- (void)testPassingNULLErrorDoesNotThrow {
    XCTAssertNoThrow([questionBuilder questionsFromJSON:kNoJSON error:NULL], @"The error parameter should not be required");
}

- (void)testRealJSONWithoutQuestionArrayIsError {
    NSString * jsonString = kNoQuestionJSON;
    XCTAssertNil([questionBuilder questionsFromJSON:jsonString error:NULL], @"No questions are contained in this JSON");
}

- (void)testValidJSONWithMissingDataSendsCorrectCode {
    NSError * error;
    [questionBuilder questionsFromJSON:kNoQuestionJSON error:&error];
    XCTAssertEqual(QuestionBuilderMissingDataError, [error code], @"Valid JSON but missing data should set QuestionBuilderMissingDataError code");
}

- (void)testJSONWithOneQuestionReturnsOneQuestionObject {
    NSError * error;
    NSArray * questions = [questionBuilder questionsFromJSON:kJSONWithOneQuestion error:&error];
    XCTAssertEqual([questions count], 1, @"We expect only 1 question from the test JSON");
}

- (void)testQuestionsFromJSONHasPropertiesPresentedInJSON {
    XCTAssertEqual(22897182, question.questionID, @"Question ID should match the data from JSON");
    XCTAssertEqual(1396804029, [question.date timeIntervalSince1970], @"Date should match data from JSON");
    XCTAssertEqualObjects(@"How to pass the in-place edited content back to the previous tableview controller (update the model)", question.title, @"Title should match data from JSON");
    XCTAssertEqual(0, question.score, @"Score should match data from JSON");
    UTPerson * person = question.person;
    XCTAssertEqualObjects(person.name, @"Tylr", @"Person name should match data from JSON");
    XCTAssertEqualObjects([person.avatarURL absoluteString], @"https://www.gravatar.com/avatar/67bfd68f04be6ae2b6fd459f94e3c3e1?s=128&d=identicon&r=PG", @"Person avatar URL should match data from JSON");
}

- (void)testQuestionCreatedFromEmptyObjectIsStillValid {
    NSArray * questions = [questionBuilder questionsFromJSON:kEmptyQuestionJSON error:NULL];
    XCTAssertEqual(1, [questions count], @"Builder should handle partial data input");
}

@end
