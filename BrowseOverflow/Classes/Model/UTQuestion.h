//
//  UTQuestion.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTPerson+Creation.h"
#import "UTAnswer.h"

@interface UTQuestion : NSObject

/** A unique ID of the question. Used to request for the body and answers */
@property (nonatomic) NSInteger questionID;
/** The creation date of the question */
@property (strong, nonatomic) NSDate * date;
/** The title of the question */
@property (copy, nonatomic) NSString * title;
/** The person that asked the question */
@property (strong, nonatomic) UTPerson * person;
/** The score of the question */
@property (nonatomic) NSInteger score;
/** The answers to the question. This is an array of UTAnswer*/
@property (copy, nonatomic) NSArray * answers;
/** The body of the question as an HTML string */
@property (copy, nonatomic) NSString * body;

/** Adding an answer to the question */
- (void)addAnswer:(UTAnswer *)answer;

@end
