//
//  TMRequestBaseDataEngine.m
//  test
//
//  Created by joinus on 16/5/24.
//  Copyright © 2016年 joinus. All rights reserved.
//

#import "TMRequestBaseDataEngine.h"
#import "TMAPIClient.h"
#import "TMBaseRequestDataModel.h"
#import "NSObject+TMNetWorkingAutoCancel.h"

@interface TMRequestBaseDataEngine ()

@property(nonatomic,strong) NSNumber * requestID;

@end

@implementation TMRequestBaseDataEngine

#pragma mark - public methods
/**
 *  取消self持有的hash的网络请求
 */
- (void)cancelRequest{
    [[TMAPIClient shareInstance] cancelRequestWithRequestID:self.requestID];
}

/// get/post
+ (TMRequestBaseDataEngine *)control:(NSObject *)control
                         path:(NSString *)path
                        param:(NSDictionary *)parameters
                  requestType:(TMManagerRequestType)requestType
                    alertType:(DataEngineAlertType)alertType
                progressBlock:(ProgressBlock)progressBlock
                     complete:(CompletionDataBlock)responseBlock
       errorButtonSelectIndex:(ErrorAlertSelectIndexBlock)errorButtonSelectIndexBlock{
    TMRequestBaseDataEngine *engine = [[TMRequestBaseDataEngine alloc]init];
    __weak typeof(control) weakControl = control;
    TMBaseRequestDataModel *dataModel = [engine dataModelWithPath:path
                                                           param:parameters
                                                    dataFilePath:nil
                                                        dataName:nil
                                                        fileName:nil
                                                        mimeType:nil
                                                     requestType:requestType
                                             uploadProgressBlock:progressBlock
                                           downloadProgressBlock:nil
                                                        complete:^(id data, NSError *error) {
                                                            if (responseBlock) {
                                                                //可以在这里做错误的UI处理，或者是在上层engine做
                                                                responseBlock(data,error);
                                                            }
                                                            [weakControl.networkingAutoCancelRequests removeEngineWithRequestID:engine.requestID];
                                                        }];
    [engine callRequestWithRequestModel:dataModel control:control];
    return engine;
}

// upload/download
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
       errorButtonSelectIndex:(ErrorAlertSelectIndexBlock)errorButtonSelectIndexBlock
{
    TMRequestBaseDataEngine *engine = [[TMRequestBaseDataEngine alloc]init];
    __weak typeof(control) weakControl = control;
    TMBaseRequestDataModel *dataModel = [engine dataModelWithPath:path
                                                            param:parameters
                                                     dataFilePath:dataFilePath
                                                         dataName:dataName
                                                         fileName:fileName
                                                         mimeType:mimeType
                                                      requestType:requestType
                                              uploadProgressBlock:uploadProgressBlock downloadProgressBlock:downloadProgressBlock
                                                         complete:^(id data, NSError *error) {
        if (responseBlock) {
            //可以在这里做错误的UI处理，或者是在上层engine做
            responseBlock(data,error);
        }
        [weakControl.networkingAutoCancelRequests removeEngineWithRequestID:engine.requestID];
    }];
    [engine callRequestWithRequestModel:dataModel control:control];
    return engine;
}

#pragma mark - UITableViewDelegate
#pragma mark - CustomDelegate
#pragma mark - event response
#pragma mark - private methods
- (TMBaseRequestDataModel *)dataModelWithPath:(NSString *)path
                                       param:(NSDictionary *)parameters
                                dataFilePath:(NSString *)dataFilePath
                                    dataName:(NSString *)dataName
                                    fileName:(NSString *)fileName
                                    mimeType:(NSString *)mimeType
                                 requestType:(TMManagerRequestType)requestType
                         uploadProgressBlock:(ProgressBlock)uploadProgressBlock
                       downloadProgressBlock:(ProgressBlock)downloadProgressBlock
                                    complete:(CompletionDataBlock)responseBlock
{
    TMBaseRequestDataModel *dataModel = [[TMBaseRequestDataModel alloc]init];
    dataModel.apiPath = path;
    dataModel.parameters = parameters;
    dataModel.dataFilePath = dataFilePath;
    dataModel.dataName = dataName;
    dataModel.mimeType = mimeType;
    dataModel.requestType = requestType;
    dataModel.uploadProgressBlock = uploadProgressBlock;
    dataModel.downloadProgressBlock = downloadProgressBlock;
    dataModel.responseBlock = responseBlock;
    return dataModel;
}

- (void)callRequestWithRequestModel:(TMBaseRequestDataModel *)dataModel control:(NSObject *)control{
    self.requestID = [[TMAPIClient shareInstance] callRequestWithRequestModel:dataModel];
    [control.networkingAutoCancelRequests setEngine:self requestID:self.requestID];
}
#pragma mark - getters and setters






-(void)dealloc{
    [self cancelRequest];
}

@end
