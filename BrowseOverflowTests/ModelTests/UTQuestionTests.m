//
//  UTQuestionTests.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UTQuestion.h"

@interface UTQuestionTests : XCTestCase {
    UTQuestion * question;
    UTAnswer * lowScoreAnswer;
    UTAnswer * highScoreAnswer;
    UTPerson * asker;
}

@end

@implementation UTQuestionTests

- (void)setUp {
    [super setUp];
    question = [[UTQuestion alloc] init];
    question.date = [NSDate distantPast];
    question.title = @"Do iPhones dream of electric sheeps?";
    question.score = 42;
    asker = [[UTPerson alloc] initWithName:@"Aurelien Cobb" avatarLocation:@"http://example.com/avatar.png"];
    question.person = asker;
    UTAnswer * acceptedAnswer = [[UTAnswer alloc] init];
    acceptedAnswer.accepted = YES;
    
    lowScoreAnswer = [[UTAnswer alloc] init];
    lowScoreAnswer.score = 1;
    
    highScoreAnswer = [[UTAnswer alloc] init];
    highScoreAnswer.score = 100;
    
    [question addAnswer:acceptedAnswer];
    [question addAnswer:lowScoreAnswer];
    [question addAnswer:highScoreAnswer];
}

- (void)tearDown {
    asker = nil;
    question = nil;
    lowScoreAnswer = nil;
    highScoreAnswer = nil;
    [super tearDown];
}

- (void)testThatQuestionHasADate {
    NSDate * testDate = [NSDate distantPast];
    question.date = testDate;
    XCTAssertEqualObjects(testDate, question.date, @"Questions must come with a date");
}

- (void)testQuestionsKeepScores {
    XCTAssertEqual(42, question.score, @"Question must keep score");
}

- (void)testQuestionsHaveTitles {
    XCTAssertEqualObjects(@"Do iPhones dream of electric sheeps?", question.title, @"Questions must have a title");
}

- (void)testThatQuestonIsAskedByPerson {
    XCTAssertEqualObjects(question.person, asker, @"The question must be asked by a person");
}

- (void)testQuestionsCanHaveAnswersAdded {
    NSUInteger answerCount = [question.answers count];
    UTAnswer * answer = [[UTAnswer alloc] init];
    [question addAnswer:answer];
    NSUInteger newCount = [question.answers count];
    XCTAssertEqual(newCount, answerCount + 1, @"Answering a question should increment the number of answers");
}

- (void)testAcceptedAnswersComeFirst {
    NSArray * answers = question.answers;
    NSUInteger indexOfLowAnswer = [answers indexOfObject:lowScoreAnswer];
    NSUInteger indexOfHighAnswer = [answers indexOfObject:highScoreAnswer];
    XCTAssertTrue(indexOfLowAnswer > indexOfHighAnswer, @"Higher scoring answers should come first");
}

@end
