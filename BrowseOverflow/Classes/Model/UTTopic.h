//
//  UTTopic.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UTQuestion;

@interface UTTopic : NSObject

- (instancetype)initWithName:(NSString *)name tag:(NSString *)tag;

- (NSArray *)recentQuestions;
- (void)addQuestion:(UTQuestion *)question;

@property (copy, nonatomic) NSString * name;
@property (copy, nonatomic) NSString * tag;

@end
