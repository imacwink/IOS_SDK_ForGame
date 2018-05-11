//
//  XYSingleton.m
//  XYSDK
//
//  Created by 王云刚 on 2018/3/10.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "XYSingleton.h"
#import <objc/runtime.h>

@implementation XYSingleton

+(instancetype)sharedInstance
{
    id instance = objc_getAssociatedObject(self, @"xysdkinstance");
    
    if (!instance)
    {
        instance = [[super allocWithZone:NULL] init];
        objc_setAssociatedObject(self, @"xysdkinstance", instance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return instance;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance] ;
}

-(id)copyWithZone:(struct _NSZone *)zone
{
    Class selfClass = [self class];
    return [selfClass sharedInstance] ;
}

/*以下代码是支持多线程的单例模式，由于无法支持继承故舍弃设计*/
/*static XYSingleton * _instance = nil;

+(instancetype) sharedInstance{
    if (_instance == nil) {
        _instance = [[super alloc] init];
    }
    return _instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(nil == _instance) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone{
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return _instance;
}*/

@end
