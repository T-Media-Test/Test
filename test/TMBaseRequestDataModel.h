//
//  TMBaseRequestDataModel.h
//  test
//
//  Created by joinus on 16/5/17.
//  Copyright © 2016年 joinus. All rights reserved.
//
/**
 *  网络请求参数传递类，只在BaseEngine以下的层次传递使用
 */
#import <Foundation/Foundation.h>
#import "TMNetWorkServerConfig.h"


@interface TMBaseRequestDataModel : NSObject

/**
 *  网络请求参数
 */
/**
*  网络请求地址
*/
@property(nonatomic,strong)NSString * apiPath;
/**
 *
 */
@property(nonatomic,strong)NSDictionary * parameters;
@property(nonatomic,assign)TMManagerRequestType requestType;
@property(nonatomic,copy)CompletionDataBlock responseBlock;


// upload
// upload file
@property (nonatomic, strong) NSString  * dataFilePath;
@property (nonatomic, strong) NSString  * dataName;
@property (nonatomic, strong) NSString  * fileName;
@property (nonatomic, strong) NSString  * mimeType;
@property (nonatomic, strong) NSData    * fileData;


// download
// download file

// progressBlock
@property (nonatomic, copy) ProgressBlock uploadProgressBlock;
@property (nonatomic, copy) ProgressBlock downloadProgressBlock;


@end
