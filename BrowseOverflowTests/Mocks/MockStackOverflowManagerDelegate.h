//
//  MockStackOverflowManagerDelegate.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTStackOverflowManager.h"

@interface MockStackOverflowManagerDelegate : NSObject <UTStackOverflowManagerDelegate>

@property (strong, nonatomic) NSError * fetchError;
@property (copy, nonatomic) NSArray * receivedAnswers;
@property (copy, nonatomic) NSArray * receivedQuestions;

@end
