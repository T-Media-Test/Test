//
//  NSObject+TMNetWorkingAutoCancel.h
//  test
//
//  Created by joinus on 16/5/24.
//  Copyright © 2016年 joinus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMNetWorkingAutoCancelRequests.h"


@interface NSObject (TMNetWorkingAutoCancel)

/**
 *  将networkingRequestArray绑定到NSObject，当NSObject释放时networkingRequestArray也会释放
 *  networkingRequestArray存放requestid，当networkingRequestArray释放的时候，根据requestid取消没有返回的网络请求
 */
@property(nonatomic, strong, readonly)TMNetWorkingAutoCancelRequests *networkingAutoCancelRequests;


@end
