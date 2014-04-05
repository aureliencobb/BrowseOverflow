//
//  MockStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTStackOverflowCommunicator.h"

@interface MockStackOverflowCommunicator : UTStackOverflowCommunicator

- (BOOL)wasAskedToFetchQuestions;

@end
