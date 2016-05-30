//
//  TMNetWorkServerConfig.h
//  test
//
//  Created by joinus on 16/5/17.
//  Copyright © 2016年 joinus. All rights reserved.
//

#ifndef TMNetWorkServerConfig_h
#define TMNetWorkServerConfig_h

#if (defined(DEBUG) || defined(ADHOC) || !defined YA_BUILD_FOR_RELEASE)
#define DELog(format, ...)  NSLog((@"FUNC:%s\n" "LINE:%d\n" format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DELog(format, ...)
#endif


typedef NS_ENUM (NSUInteger, TMManagerRequestType){
    TMManagerRequestTypeGet,                 //get请求
    TMManagerRequestTypePost,                //POST请求
    TMManagerRequestTypePostUpload,             //POST数据请求
    TMManagerRequestTypeGETDownload             //下载文件请求，不做返回值解析
};

typedef NS_ENUM(NSInteger, DataEngineAlertType) {
    DataEngineAlertType_None,
    DataEngineAlertType_Toast,
    DataEngineAlertType_Alert,
    DataEngineAlertType_ErrorView
};


typedef void (^ProgressBlock)(NSProgress *taskProgress);
typedef void (^CompletionDataBlock)(id data, NSError *error);
typedef void (^ErrorAlertSelectIndexBlock)(NSUInteger buttonIndex);




#endif /* TMNetWorkServerConfig_h */
