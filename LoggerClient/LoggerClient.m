//
//  LoggerClient.m
//  LoggerClient
//
//  Created by 聪宁陈 on 16/9/30.
//  Copyright © 2016年 ccnyou. All rights reserved.
//

#import "LoggerClient.h"
#import "CocoaAsyncSocket.h"

typedef void(^CompletionBlock)(NSError *error);

@interface LoggerClient () <GCDAsyncSocketDelegate>

@property (nonatomic, strong) GCDAsyncSocket* socket;
@property (nonatomic,   copy) CompletionBlock completion;
@end

@implementation LoggerClient

+ (LoggerClient *)client {
    static LoggerClient* sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedInstance = [[LoggerClient alloc] init];
    });
    
    return sharedInstance;
}

- (GCDAsyncSocket *)socket {
    if (!_socket) {
        dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
        _socket = [[GCDAsyncSocket alloc] initWithDelegate:self
                                             delegateQueue:queue];
    }
    
    return _socket;
}

- (BOOL)isConnected {
    return self.socket.isConnected;
}

- (void)connect:(NSString *)server port:(NSString *)port completion:(CompletionBlock)completionBlock {
    self.completion = completionBlock;
    NSError* error = nil;
    
    [self.socket connectToHost:server onPort:[port integerValue] error:&error];
    if (error && completionBlock) {
        completionBlock(error);
        self.completion = nil;
    }
}

- (void)disconnect {
    
}

- (void)sendText:(NSString *)text {
    if ([text rangeOfString:@"\r\n"].location == NSNotFound) {
        text = [text stringByAppendingString:@"\r\n"];
    }
    
    NSData* data = [text dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket writeData:data withTimeout:10.0f tag:0];
}

#pragma mark - Socket Delegate

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    self.completion(nil);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
}

@end
