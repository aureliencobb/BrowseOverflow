//
//  UTPerson+Creation.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 07/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTPerson+Creation.h"

NSString * const kUserNameKey = @"display_name";
NSString * const kImageLinkKey = @"profile_image";

@implementation UTPerson (Creation)

+ (UTPerson *)personFromJSONDictionary:(NSDictionary *)jsonDictionary {
    NSString * name = [jsonDictionary objectForKey:kUserNameKey];
    NSString * link = [jsonDictionary objectForKey:kImageLinkKey];
    UTPerson * person = [[UTPerson alloc] initWithName:name avatarLocation:link];
    return person;
}

@end
