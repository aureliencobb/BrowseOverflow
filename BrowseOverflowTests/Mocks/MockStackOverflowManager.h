//
//  MockStackOverflowManager.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 10/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTStackOverflowManager.h"

@interface MockStackOverflowManager : UTStackOverflowManager {
    NSInteger _topicFailureErrorCode;
    NSInteger _answerFailureErrorCode;
    NSString * _topicSearchString;
    NSString * _answerDownloadString;
}

- (NSInteger)topicFailureCode;
- (NSInteger)topicFailureErrorCode;
- (NSString *)topicSearchString;
- (NSString *)answerListString;

@end
