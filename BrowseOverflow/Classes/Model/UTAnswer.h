//
//  UTAnswer.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UTPerson.h"

@interface UTAnswer : NSObject

@property (copy, nonatomic) NSString * text;
@property (nonatomic) NSInteger score;
@property (nonatomic) BOOL accepted;
@property (strong, nonatomic) UTPerson * person;

@end
