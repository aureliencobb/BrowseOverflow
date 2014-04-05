//
//  MockStackOverflowManagerDelegate.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"

@implementation MockStackOverflowManagerDelegate

- (void)fetchingQuestionsFailedWithError:(NSError *)error {
    self.fetchError = error;
}

- (void)didReceiveQuestions:(NSArray *)questions {
    self.receivedQuestions = questions;
}

@end
