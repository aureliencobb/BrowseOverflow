//
//  UTPerson.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTPerson.h"

@implementation UTPerson

- (instancetype)initWithName:(NSString *)name avatarLocation:(NSString *)avatarLocation {
    self = [super init];
    if (self) {
        self.name = name;
        self.avatarURL = [NSURL URLWithString:avatarLocation];
    }
    return self;
}

@end
