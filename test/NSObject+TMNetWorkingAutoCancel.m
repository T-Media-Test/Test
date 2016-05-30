//
//  NSObject+TMNetWorkingAutoCancel.m
//  test
//
//  Created by joinus on 16/5/24.
//  Copyright © 2016年 joinus. All rights reserved.
//

#import "NSObject+TMNetWorkingAutoCancel.h"
#import <objc/runtime.h>

@implementation NSObject (TMNetWorkingAutoCancel)

-(TMNetWorkingAutoCancelRequests *)networkingAutoCancelRequests{
    TMNetWorkingAutoCancelRequests * requests = objc_getAssociatedObject(self, @selector(networkingAutoCancelRequests));
    if (requests == nil) {
        requests = [[TMNetWorkingAutoCancelRequests alloc] init];
        objc_setAssociatedObject(self, @selector(networkingAutoCancelRequests), requests, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return  requests;
}

@end
