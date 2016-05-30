//
//  TMRequestBaseDataEngine.h
//  test
//
//  Created by joinus on 16/5/24.
//  Copyright © 2016年 joinus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMNetWorkServerConfig.h"


@interface TMRequestBaseDataEngine : NSObject

/**
 *  取消self持有的hask的网络请求
 */
-(void)cancelRequest;

/**
 *  下面的区分get/post/upload/download只是为了上层Engine调用方便，实现都是一样的
 */
/// get/post
+ (TMRequestBaseDataEngine *)control:(NSObject *)control
                         path:(NSString *)path
                        param:(NSDictionary *)parameters
                  requestType:(TMManagerRequestType)requestType
                    alertType:(DataEngineAlertType)alertType
                progressBlock:(ProgressBlock)progressBlock
                     complete:(CompletionDataBlock)responseBlock
       errorButtonSelectIndex:(ErrorAlertSelectIndexBlock)errorButtonSelectIndexBlock;

// upload
+ (TMRequestBaseDataEngine *)control:(NSObject *)control
                         path:(NSString *)path
                        param:(NSDictionary *)parameters
                 dataFilePath:(NSString *)dataFilePath
                     dataName:(NSString *)dataName
                     fileName:(NSString *)fileName
                     mimeType:(NSString *)mimeType
                  requestType:(TMManagerRequestType)requestType
                    alertType:(DataEngineAlertType)alertType
          uploadProgressBlock:(ProgressBlock)uploadProgressBlock
        downloadProgressBlock:(ProgressBlock)downloadProgressBlock
                     complete:(CompletionDataBlock)responseBlock
       errorButtonSelectIndex:(ErrorAlertSelectIndexBlock)errorButtonSelectIndexBlock;

// download



@end
