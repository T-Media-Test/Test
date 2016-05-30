//
//  TMURLRequestGenerator.h
//  test
//
//  Created by joinus on 16/5/17.
//  Copyright © 2016年 joinus. All rights reserved.
//
/**
 *  生成网络请求所需URLRequest
 */

#import <Foundation/Foundation.h>
#import "TMBaseRequestDataModel.h"

@interface TMURLRequestGenerator : NSObject


+(instancetype)sharedInstance;

-(NSURLRequest *)generatorWithRequestDataModel:(TMBaseRequestDataModel *)dataModel;


@end
