//
//  InspectableStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 09/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "InspectableStackOverflowCommunicator.h"

@implementation InspectableStackOverflowCommunicator

- (NSURL *)URLToFetch {
    return _fetchingURL;
}

- (NSURLConnection *)currentURLConnection {
    return _fetchingConnection;
}

@end
