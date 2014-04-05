//
//  UTTopicTests.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UTTopic.h"
#import "UTQuestion.h"

@interface UTTopicTests : XCTestCase {
    UTTopic * topic;
}

@end

@implementation UTTopicTests

- (void)setUp {
    [super setUp];
    topic = [[UTTopic alloc] initWithName:@"iPhone" tag:@"ios"];
}

- (void)tearDown {
    topic = nil;
    [super tearDown];
}

- (void)testThatTopicClassExists {
    XCTAssertNotNil(topic, @"Should be able to create a topic instance");
}

- (void)testThatTopicHasAName {
    XCTAssertEqualObjects(topic.name, @"iPhone", @"The topic should have the name I gave it");
}

- (void)testThatTopicHasATag  {
    XCTAssertEqualObjects(topic.tag, @"ios", @"The topic should have the tag I gave it");
}

- (void)testForAListOfQuestions {
    XCTAssertTrue([[topic recentQuestions] isKindOfClass:[NSArray class]], @"Topics should provide a list of questions");
}

- (void)testThatTopicHasInitiallyNoQuestions {
    XCTAssertEqual([[topic recentQuestions] count], 0, @"A topic should start initially with no questions");
}

- (void)testAddingQuestion {
    UTQuestion * question = [[UTQuestion alloc] init];
    [topic addQuestion:question];
    XCTAssertEqual([[topic recentQuestions] count], 1, @"Adding a question should put it in the list");
}

- (void)testQuestionsAreListedChronologically {
    UTQuestion * q1 = [[UTQuestion alloc] init];
    UTQuestion * q2 = [[UTQuestion alloc] init];
    q1.date = [NSDate distantPast];
    q2.date = [NSDate distantFuture];
    [topic addQuestion:q1];
    [topic addQuestion:q2];
    NSArray * questions = [topic recentQuestions];
    UTQuestion * listedFirst = questions[0];
    UTQuestion * listedLast = questions[1];
    XCTAssertEqualObjects([listedFirst.date laterDate:listedLast.date], listedFirst.date, @"The newer questions should appear at the beginning of the list");
}

- (void)testLimitOfTwentyQuestions {
    UTQuestion * question = [[UTQuestion alloc] init];
    for (NSInteger i = 0; i < 21; i++) {
        [topic addQuestion:question];
    }
    XCTAssertEqual(20, [[topic recentQuestions] count], @"There should be a maximum of 20 recent questions");
}

@end
