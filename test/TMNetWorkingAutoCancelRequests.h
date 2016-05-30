//
//  TMNetWorkingAutoCancelRequests.h
//  test
//
//  Created by joinus on 16/5/24.
//  Copyright © 2016年 joinus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMRequestBaseDataEngine.h"

@interface TMNetWorkingAutoCancelRequests : NSObject

-(void)setEngine:(TMRequestBaseDataEngine *)engine requestID:(NSNumber *)requestID;

-(void)removeEngineWithRequestID:(NSNumber *)requestID;

@end
