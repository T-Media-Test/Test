//
//  TMResponseErrorHandler.h
//  test
//
//  Created by joinus on 16/5/24.
//  Copyright © 2016年 joinus. All rights reserved.
//
/**
 *  网络请求错误信息处理
 */

#import <Foundation/Foundation.h>
#import "TMBaseRequestDataModel.h"

@interface TMResponseErrorHandler : NSObject

+ (void)errorHandlerWithRequestDataModel:(TMBaseRequestDataModel *)requestDataModel responseURL:(NSURLResponse *)responseURL responseObject:(id)responseObject error:(NSError *)error errorHandler:(void(^)(NSError *newError))errorHandler;


@end
