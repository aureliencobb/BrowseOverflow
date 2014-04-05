//
//  UTTopic.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTTopic.h"
#import "UTQuestion.h"

@interface UTTopic()

@property (copy, nonatomic) NSArray * questions;

@end

@implementation UTTopic

- (instancetype)initWithName:(NSString *)name tag:(NSString *)tag {
    self = [super init];
    if (self) {
        self.name = name;
        self.tag = tag;
        self.questions = [NSArray array];
    }
    return self;
}

- (NSArray *)recentQuestions {
    return [self sortedQuestionsLatestFirst:self.questions];
}

- (void)addQuestion:(UTQuestion *)question {
    NSArray * newList = [self.questions arrayByAddingObject:question];
    if ([newList count] > 20) {
        newList = [self sortedQuestionsLatestFirst:newList];
        newList = [newList subarrayWithRange:NSMakeRange(0, 20)];
    }
    self.questions = newList;
}

#pragma mark - Private Methods

- (NSArray *)sortedQuestionsLatestFirst:(NSArray *)questionList {
    return [self.questions sortedArrayUsingComparator:^NSComparisonResult(UTQuestion * q1, UTQuestion * q2) {
        return [q2.date compare:q1.date];
    }];
}

@end
