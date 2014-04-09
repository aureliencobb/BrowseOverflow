//
//  MockStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTStackOverflowCommunicator.h"

@interface MockStackOverflowCommunicator : UTStackOverflowCommunicator

@property (assign, readonly) BOOL wasAskedToFetchQuestions;
@property (assign, readonly) BOOL wasAskedToFetchAnswers;

@end
