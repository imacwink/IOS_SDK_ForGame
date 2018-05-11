//
//  XYSDKInstance.h
//  XYSDK
//
//  Created by 王云刚 on 2018/3/11.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "XYSDKParam.h"

#pragma mark - XYSDKDelegate
/*! @brief 接收并处理来自小悦SDK的事件消息
 *
 */
@protocol XYSDKDelegate <NSObject>
@optional

@end

@class XYRootViewController;
@interface XYSDKInstance : NSObject {
    XYRootViewController * _vcRoot;
}

+(instancetype) sharedInstance;

-(void)init:(XYSDKParam *) sdkParam;
-(void)open:(UIViewController *)parentVC;

@end
