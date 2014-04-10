//
//  FakeURLResponse.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 10/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeURLResponse : NSObject

- (instancetype)initWithStatusCode:(NSInteger)statusCode;

@property NSInteger statusCode;

@end
