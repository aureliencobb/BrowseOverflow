//
//  UTStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTStackOverflowCommunicator.h"

@implementation UTStackOverflowCommunicator

- (void)searchForQuestionsWithTag:(NSString *)tag {
    NSString * urlStr = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=activity&tagged=%@&site=stackoverflow&filter=withbody", tag];
    [self fetchContentAtURL:[NSURL URLWithString:urlStr]];
}

- (void)downloadAnswersForQuestionID:(NSInteger)questionID {
    NSString * urlStr = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/questions/%d/answers?order=desc&sort=activity&site=stackoverflow&filter=withbody", questionID];
    [self fetchContentAtURL:[NSURL URLWithString:urlStr]];
}

- (void)cancelAndDiscardURLConnection {
    [_fetchingConnection cancel];
    _fetchingConnection = nil;
}

#pragma mark - Private Methods

- (void)fetchContentAtURL:(NSURL *)url {
    _fetchingConnection = [[NSURLConnection alloc] init];
    _fetchingURL = url;
}

@end
