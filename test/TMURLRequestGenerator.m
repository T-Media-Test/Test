//
//  TMURLRequestGenerator.m
//  test
//
//  Created by joinus on 16/5/17.
//  Copyright © 2016年 joinus. All rights reserved.
//

#import "TMURLRequestGenerator.h"
#import "TMNetWorkServerConfig.h"
#import "AFURLRequestSerialization.h"


static NSTimeInterval TMNetWorkingTimeoutSeconds = 20.0f;
@interface TMURLRequestGenerator ()

@property(nonatomic,strong)AFHTTPRequestSerializer * httpRequestSerializer;

@end



@implementation TMURLRequestGenerator

+(instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    static TMURLRequestGenerator * sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TMURLRequestGenerator alloc] init];
    });
    return sharedInstance;
}


-(NSURLRequest *)generatorWithRequestDataModel:(TMBaseRequestDataModel *)dataModel{
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params addEntriesFromDictionary:dataModel.parameters];
    
    
    NSString * urlString = [self URLStringWithServiceUrl:@"" path:dataModel.apiPath];
    
    NSError * error;
    NSMutableURLRequest * request;
    
    if (dataModel.requestType == TMManagerRequestTypeGet) {
        request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:params error:&error];
    }else if (dataModel.requestType == TMManagerRequestTypePost){
        request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:params error:&error];
    }else if (dataModel.requestType == TMManagerRequestTypePostUpload){
        request = [self.httpRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            /**
             *  这里的参数配置也可以根据自己的设计修改默认值.
             *  如果data跟文件地址二选一
             */
            
            NSString *name = dataModel.dataName?dataModel.dataName:@"data";
            NSString *fileName = dataModel.fileName?dataModel.fileName:@"data.zip";
            NSString *mimeType = dataModel.mimeType?dataModel.mimeType:@"application/zip";
            NSError *error;
            
            if (dataModel.fileData)
            {
                [formData appendPartWithFileData:dataModel.fileData name:name fileName:fileName mimeType:mimeType];
            } else
            {
                if (dataModel.dataFilePath.length)
                {
                    NSURL *fileURL = [NSURL fileURLWithPath:dataModel.dataFilePath];
                    
                    [formData appendPartWithFileURL:fileURL
                                               name:name
                                           fileName:fileName
                                           mimeType:mimeType
                                              error:&error];
                }
            }
            
        } error:&error];
    } else if (dataModel.requestType == TMManagerRequestTypeGETDownload) {
        request = [self.httpRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
        } error:&error];
    }
    
    if (error || request == nil) {
        DELog(@"NSMutableURLRequests生成失败：\n---------------------------\n\
              urlString:%@\n\
              \n---------------------------\n",urlString);
        return nil;
    }
    
    request.timeoutInterval = TMNetWorkingTimeoutSeconds;
    
    return request;
}



#pragma mark - private methods
- (NSString *)URLStringWithServiceUrl:(NSString *)serviceUrl path:(NSString *)path{
    NSURL *fullURL = [NSURL URLWithString:serviceUrl];
    if (path.length) {
        fullURL = [NSURL URLWithString:path relativeToURL:fullURL];
    }
    if (fullURL == nil) {
        DELog(@"YAAPIURLRequestGenerator--URL拼接错误:\n---------------------------\n\
              apiBaseUrl:%@\n\
              urlPath:%@\n\
              \n---------------------------\n",serviceUrl,path);
        return nil;
    }
    return [fullURL absoluteString];
}



#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = TMNetWorkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}



@end
