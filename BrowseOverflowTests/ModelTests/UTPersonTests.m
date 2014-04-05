//
//  UTPersonTests.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UTPerson.h"

@interface UTPersonTests : XCTestCase {
    UTPerson * person;
}

@end

@implementation UTPersonTests

- (void)setUp {
    [super setUp];
    person = [[UTPerson alloc] initWithName:@"Aurelien Cobb" avatarLocation:@"http://example.com/avatar.png"];
}

- (void)tearDown
{
    person = nil;
    [super tearDown];
}

- (void)testThatPersonHasTheRightName {
    XCTAssertEqualObjects(@"Aurelien Cobb", person.name, @"Person must have the right name");
}

- (void)testThatPersonHasAnAvatarURL {
    NSURL * url = person.avatarURL;
    XCTAssertEqualObjects(@"http://example.com/avatar.png", [url absoluteString], @"The person's avatar must be represented by an URL");
}


@end
