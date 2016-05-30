//
//  TMAPIClient.m
//  test
//
//  Created by joinus on 16/5/17.
//  Copyright © 2016年 joinus. All rights reserved.
//



#import "TMAPIClient.h"
#import "AFURLSessionManager.h"
#import "TMURLRequestGenerator.h"
#import "TMResponseErrorHandler.h"


@interface TMAPIClient ()

@property(nonatomic,strong) AFURLSessionManager * sessionManager;
//根据 requestID 存放 task
@property(nonatomic,strong) NSMutableDictionary * dispatchList;
@property(nonatomic,strong) NSNumber * recordRequestID;
//根据 requestID 存放 requestModel
@property(nonatomic,strong) NSMutableDictionary * requestModelDict;

@end


@implementation TMAPIClient

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static TMAPIClient * sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TMAPIClient alloc] init];
    });
    return sharedInstance;
}

-(NSNumber *)callRequestWithRequestModel:(TMBaseRequestDataModel *)requestModel{
    
    NSURLRequest * request = [[TMURLRequestGenerator sharedInstance] generatorWithRequestDataModel:requestModel];
    typeof(self) __weak wself = self;
    AFURLSessionManager * sessionManager = self.sessionManager;
    NSURLSessionDataTask * task = [sessionManager dataTaskWithRequest:request
                                                       uploadProgress:requestModel.uploadProgressBlock
                                                     downloadProgress:requestModel.downloadProgressBlock completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)
    {
        if (task.state == NSURLSessionTaskStateCanceling) {
            //如果请求是取消状态，那就不处理回调
        }else {
            NSNumber * requestID = [NSNumber numberWithUnsignedInteger:task.hash];
            [wself.dispatchList removeObjectForKey:requestID];
            
            //在这里做网络错误的解析，只是整理成error(包含重新发起请求，比如重新获取签名后再次请求),不做任何UI处理(包含reload，常规reload不在这里处理)，
            //解析完成后通过调用requestModel.responseBlock进行回调

            [TMResponseErrorHandler errorHandlerWithRequestDataModel:requestModel responseURL:response responseObject:responseObject error:error errorHandler:^(NSError *newError) {
                
                requestModel.responseBlock(responseObject,newError);
            }];
        }
    }];
    
    [task resume];
    NSNumber * requestID = [NSNumber numberWithUnsignedInteger:task.hash];
    [self.dispatchList setObject:task forKey:requestID];
    
    return requestID;
}

/**
 *  取消网络请求
 */
-(void)cancelRequestWithRequestID:(NSNumber *)requestID{
    NSURLSessionDataTask * task = [self.dispatchList objectForKey:requestID];
    [task cancel];
    [self.dispatchList removeObjectForKey:requestID];
}

-(void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList{
    __weak typeof(self)wself = self;
    [requestIDList enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSURLSessionDataTask * task = [wself.dispatchList objectForKey:obj];
        [task cancel];
    }];
    
    [self.dispatchList removeObjectsForKeys:requestIDList];
}

#pragma mark - UITableViewDelegate
#pragma mark - CustomDelegate
#pragma mark - event response
#pragma mark - private methods
- (AFURLSessionManager *)getCommonSessionManager
{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForResource = 20;
    
    AFURLSessionManager *sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    return sessionManager;
}

#pragma mark - getters and setters
- (AFURLSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [self getCommonSessionManager];
        _sessionManager.responseSerializer  = [AFJSONResponseSerializer serializer];
        
    }
    return _sessionManager;
}
- (NSMutableDictionary *)dispatchTable{
    if (_dispatchList == nil) {
        _dispatchList = [[NSMutableDictionary alloc] init];
    }
    return _dispatchList;
}


@end







