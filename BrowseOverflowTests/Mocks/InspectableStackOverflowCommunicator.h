//
//  InspectableStackOverflowCommunicator.h
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 09/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTStackOverflowCommunicator.h"

@interface InspectableStackOverflowCommunicator : UTStackOverflowCommunicator

- (NSURL *)URLToFetch;
- (NSURLConnection *)currentURLConnection;

@end
