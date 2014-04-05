//
//  FakeQuestionBuilder.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTQuestionBuilder.h"

@interface FakeQuestionBuilder : UTQuestionBuilder

@property (copy, nonatomic) NSString * JSON;
@property (copy, nonatomic) NSArray * arrayToReturn;
@property (copy, nonatomic) NSError * errorToSet;

@end
