//
//  UTStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UTStackOverflowCommunicator : NSObject

- (void)searchForQuestionsWithTag:(NSString *)tag;
- (void)downloadQuestionBodyWithID:(NSUInteger)questionID;

@end
