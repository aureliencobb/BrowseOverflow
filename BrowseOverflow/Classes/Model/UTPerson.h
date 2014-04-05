//
//  UTPerson.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UTPerson : NSObject

- (instancetype)initWithName:(NSString *)name avatarLocation:(NSString *)avatarLocation;

@property (copy, nonatomic) NSString * name;
@property (strong, nonatomic) NSURL * avatarURL;

@end
