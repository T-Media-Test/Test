//
//  TMNetWorkingAutoCancelRequests.m
//  test
//
//  Created by joinus on 16/5/24.
//  Copyright © 2016年 joinus. All rights reserved.
//

#import "TMNetWorkingAutoCancelRequests.h"

@interface TMNetWorkingAutoCancelRequests ()

@property(nonatomic,strong) NSMutableDictionary<NSNumber *,TMRequestBaseDataEngine *> * requestEngines;

@end

@implementation TMNetWorkingAutoCancelRequests


-(NSMutableDictionary *)requestEngines{
    if (_requestEngines == nil) {
        _requestEngines = [[NSMutableDictionary alloc] init];
    }
    return _requestEngines;
}

-(void)setEngine:(TMRequestBaseDataEngine *)engine requestID:(NSNumber *)requestID{
    if (engine && requestID) {
        self.requestEngines[requestID] = engine;
    }
}

-(void)removeEngineWithRequestID:(NSNumber *)requestID{
    if (requestID) {
        [self.requestEngines removeObjectForKey:requestID];
    }
}


@end
