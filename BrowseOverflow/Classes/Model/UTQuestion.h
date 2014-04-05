//
//  UTQuestion.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTPerson.h"
#import "UTAnswer.h"

@interface UTQuestion : NSObject

@property (strong, nonatomic) NSDate * date;
@property (copy, nonatomic) NSString * title;
@property (strong, nonatomic) UTPerson * person;
@property (nonatomic) NSInteger score;
@property (copy, nonatomic) NSArray * answers;

- (void)addAnswer:(UTAnswer *)answer;

@end
