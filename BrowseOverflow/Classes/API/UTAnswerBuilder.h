//
//  UTAnswerBuilder.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 08/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTAnswer.h"

typedef NS_ENUM(NSInteger, AnswerBuilderErrorCode) {
    AnswerBuilderInvalidJSONError = 3456,
    AnswerBuilderMissingDataError = 3457
};


@interface UTAnswerBuilder : NSObject

- (NSArray *)answersFromJSON:(NSString *)objectNotation error:(NSError *__autoreleasing *)error;

@end
