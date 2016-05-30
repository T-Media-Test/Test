//
//  TMAPIClient.h
//  test
//
//  Created by joinus on 16/5/17.
//  Copyright © 2016年 joinus. All rights reserved.
//
/**
 *   Client 负责 计算 request， 发起请求。做出回调,尽量不暴露 底层实现。比如 AF，NSSessionData
 */

#import <Foundation/Foundation.h>
#import "TMBaseRequestDataModel.h"

@interface TMAPIClient : NSObject

+(instancetype)shareInstance;


/**
 *  根据dataModel发起网络请求，并根据dataModel发起回调
 *  @return 网络请求task哈希值
 */
-(NSNumber *)callRequestWithRequestModel:(TMBaseRequestDataModel *)requestModel;
/**
 *  取消网络请求
 */
-(void)cancelRequestWithRequestID:(NSNumber *)requestID;
-(void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList;


@end
