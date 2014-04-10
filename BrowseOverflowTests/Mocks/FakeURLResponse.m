//
//  FakeURLResponse.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 10/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "FakeURLResponse.h"

@implementation FakeURLResponse

- (instancetype)initWithStatusCode:(NSInteger)statusCode {
    self = [super init];
    if (self) {
        _statusCode = statusCode;
    }
    return self;
}

@end
