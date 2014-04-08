//
//  UTPerson.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UTPerson : NSObject

/** Instantiation of a UTPerson witn name and avatar image url location
 *  @param name: The user screen name as NSString
 *  @param avatarLocatiob: The user avatar image location as NSString. It must be convertivle to an NSURL 
 */
- (instancetype)initWithName:(NSString *)name avatarLocation:(NSString *)avatarLocation;

@property (copy, nonatomic) NSString * name;
@property (strong, nonatomic) NSURL * avatarURL;

@end
