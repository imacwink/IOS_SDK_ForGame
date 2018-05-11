//
//  XYBundleManager.h
//  XYSDK
//
//  Created by 王云刚 on 2018/3/12.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "XYSingleton.h"
#import <UIKit/UIKit.h>

#define XYLocalizedString(key, comment)  [[XYBundleManager sharedInstance] getLocText:(key)] /*获取本地化文本*/
#define XYBundleImage(imageName, comment)  [[XYBundleManager sharedInstance] getImage:(imageName)] /*获取Image资源*/

@interface XYBundleManager : XYSingleton

-(void)initMgr;

-(NSString *)getLocText:(NSString *)key; /*获取本地化文本*/
-(UIImage *)getImage:(NSString *)imageName; /*获取Image资源*/

@end
