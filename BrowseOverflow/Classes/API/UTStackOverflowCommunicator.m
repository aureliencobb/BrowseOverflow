//
//  UTStackOverflowCommunicator.m
//  BrowseOverflow
//
//  Created by Aurelien Cobb on 05/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UTStackOverflowCommunicator.h"

NSString * const StackOverFlowComminucationErrorDomain = @"StackOverFlowComminucationErrorDomain";

@interface UTStackOverflowCommunicator()

@property (strong, nonatomic) NSMutableData * receivedData;
@property (strong, nonatomic) NSURL * fetchingURL;
@property (strong, nonatomic) NSURLConnection * fetchingConnection;
@property (nonatomic, copy) void (^errorHandler)(NSError *);
@property (nonatomic, copy) void (^successHandler)(NSString *);

@end

@implementation UTStackOverflowCommunicator

- (void)searchForQuestionsWithTag:(NSString *)tag {
    NSString * urlStr = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/questions?pagesize=20&order=desc&sort=activity&tagged=%@&site=stackoverflow&filter=withbody", tag];
    [self fetchContentAtURL:[NSURL URLWithString:urlStr] errorHandler:^(NSError * error) {
        [self.delegate searchingForQuestionsFailedWithError:error];
    } successHandler:^(NSString * objectNotation) {
        [self.delegate receivedQuestionsJSON:objectNotation];
    }];
}

- (void)downloadAnswersForQuestionID:(NSInteger)questionID {
    NSString * urlStr = [NSString stringWithFormat:@"https://api.stackexchange.com/2.2/questions/%d/answers?order=desc&sort=activity&site=stackoverflow&filter=withbody", questionID];
    [self fetchContentAtURL:[NSURL URLWithString:urlStr] errorHandler:^(NSError * error) {
        [self.delegate dowloadingAnswersFailedWithError:error];
    } successHandler:^(NSString * objectNotation) {
        [self.delegate receivedAnswersJSON:objectNotation];
    }];
}

- (void)cancelAndDiscardURLConnection {
    if (_fetchingConnection) {
        [_fetchingConnection cancel];
        _fetchingConnection = nil;
    }
}

- (void)dealloc {
    [self.fetchingConnection cancel];
}

#pragma mark - NSURLConnectionDataDelegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.receivedData = nil;
    NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
    if (httpResponse.statusCode != 200) {
        NSError * error = [NSError errorWithDomain:StackOverFlowComminucationErrorDomain code:httpResponse.statusCode userInfo:nil];
        self.errorHandler(error);
        [self cancelAndDiscardURLConnection];
    } else {
        self.receivedData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.fetchingConnection = nil;
    self.fetchingURL = nil;
    NSString * objectNotation = [[NSString alloc] initWithData:self.receivedData encoding:NSUTF8StringEncoding];
    self.receivedData = nil;
    self.successHandler(objectNotation);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.receivedData = nil;
    self.fetchingConnection = nil;
    self.fetchingURL = nil;
    self.errorHandler(error);
}

#pragma mark - Private Methods

- (void)fetchContentAtURL:(NSURL *)url errorHandler:(void(^)(NSError *))errorBlock successHandler:(void(^)(NSString *))successBlock {
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    self.fetchingURL = url;
    self.errorHandler = errorBlock;
    self.successHandler = successBlock;
    [self launchConnectionForRequest:request];
}

- (void)launchConnectionForRequest:(NSURLRequest *)request {
    [self cancelAndDiscardURLConnection];
    self.fetchingConnection = [NSURLConnection connectionWithRequest:request delegate:self];
}

@end
