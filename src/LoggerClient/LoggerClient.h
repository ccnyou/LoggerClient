//
//  LoggerClient.h
//  LoggerClient
//
//  Created by 聪宁陈 on 16/9/30.
//  Copyright © 2016年 ccnyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoggerClient : NSObject

@property (nonatomic, copy) void (^logBlock)(NSString *text);

+ (LoggerClient *)client;
- (BOOL)isConnected;
- (void)connect:(NSString *)server port:(NSString *)port completion:(void (^)(NSError *error))completionBlock;
- (void)disconnect;
- (void)sendText:(NSString *)text;

@end
