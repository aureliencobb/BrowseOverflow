//
//  UTPerson+Creation.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 07/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTPerson.h"

@interface UTPerson (Creation)

+ (UTPerson *)personFromJSONDictionary:(NSDictionary *)jsonDictionary;

@end
