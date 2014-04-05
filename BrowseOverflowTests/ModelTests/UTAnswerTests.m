//
//  UTAnswerTests.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UTAnswer.h"

@interface UTAnswer(tests)

- (NSComparisonResult)compare:(UTAnswer *)otherAnswer;

@end

@interface UTAnswerTests : XCTestCase {
    UTAnswer * answer;
    UTAnswer * otherAnswer;
}

@end

@implementation UTAnswerTests

- (void)setUp {
    [super setUp];
    answer = [[UTAnswer alloc] init];
    answer.text = @"The answer is 42";
    answer.score = 42;
    answer.person = [[UTPerson alloc] initWithName:@"Aurelien Cobb" avatarLocation:@"http://example.com/acatar.png"];
    otherAnswer = [[UTAnswer alloc] init];
    otherAnswer.score = 42;
    otherAnswer.text = @"This is another answer";
}

- (void)tearDown {
    answer = nil;
    [super tearDown];
}

- (void)testThatAnswerHasSomeText {
    XCTAssertEqualObjects(@"The answer is 42", answer.text, @"The answer need to contain some text");
}

- (void)testThatSomeoneProvidedAnswer {
    XCTAssertTrue([answer.person isKindOfClass:[UTPerson class]], @"The answer must come form a person");
}

- (void)testAnswersAreNotAcceptedByDefault {
    XCTAssertFalse(answer.accepted, @"Answers must not be accepted by default");
}

- (void)testAnswerHasScore {
    XCTAssertEqual(42, answer.score, @"The answer must have a score");
}

- (void)testAcceptedAnswersComeBeforeUnaccepted {
    otherAnswer.accepted = YES;
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedDescending, @"Accepted answers should come first");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedAscending, @"Accepted answers should come first");
}

- (void)testAnswersWithEqualScoresCompareEqually {
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedSame, @"Answers with equal scores should compare equally");
}

- (void)testAnswersWithHigherScoreComesFirst {
    otherAnswer.score = 50;
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedDescending, @"Higher scores answers should come first");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedAscending, @"Higher scores answers should come first");
}

@end
