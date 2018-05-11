//
//  XYSDKInstance.m
//  XYSDK
//
//  Created by 王云刚 on 2018/3/11.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "XYSDKInstance.h"
#import "XYLogManager.h"
#import "XYBundleManager.h"
#import "XYPersistenceManager.h"
#import "XYNetworkManager.h"
#import "XYRootViewController.h"

@interface XYSDKInstance() <XYRootViewControllerDelegate>

-(void)serviceInit;

@end

@implementation XYSDKInstance

#pragma mark - Singleton
static XYSDKInstance * _instance = nil;

+(instancetype) sharedInstance {
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
}

#pragma mark - Public Func

-(void)init:(XYSDKParam *) sdkParam{
    /*XY SDK Log 工具初始化*/
    
    /*XY SDK 参数设置*/
    
    /*初始化 Service */
    [self serviceInit];
}

-(void)open:(UIViewController *)parentVC{
    if(nil == _vcRoot) {
        _vcRoot = [[XYRootViewController alloc] init];
        _vcRoot.view.frame = parentVC.view.bounds;
        _vcRoot.delegate = self;
    }
    
    /*添加视图到跟UI*/
    [parentVC.view addSubview:_vcRoot.view];
}

#pragma mark - XYRootViewControllerDelegate
-(void)closeVCAction{
    if(_vcRoot) {
        [_vcRoot.view removeFromSuperview];
        _vcRoot = nil;
    }
}

#pragma mark - Private Func
-(void)serviceInit{
    [[XYBundleManager sharedInstance] initMgr];
    [[XYPersistenceManager sharedInstance] initMgr];
    [[XYNetworkManager sharedInstance] initMgr];
}
@end
