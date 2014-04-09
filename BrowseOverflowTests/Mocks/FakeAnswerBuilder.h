//
//  FakeAnswerBuilder.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 09/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTAnswerBuilder.h"

@interface FakeAnswerBuilder : UTAnswerBuilder

@property (copy, nonatomic) NSString * JSON;
@property (strong, nonatomic) NSError * errorToSet;
@property (copy, nonatomic) NSArray * answersToReturn;

@end
