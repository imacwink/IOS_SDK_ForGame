//
//  XYBundleManager.m
//  XYSDK
//
//  Created by 王云刚 on 2018/3/12.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "XYBundleManager.h"

#define XYSDKBundle_Name @"XYSDKBundle.bundle"
#define XYSDKBundle_Loc_Name @"lproj"

@interface XYBundleManager()

@end

@implementation XYBundleManager

-(void)initMgr {
}

-(NSString *)getLocText:(NSString *)key {
    NSString * bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:XYSDKBundle_Name];
    NSBundle * bundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString * language = [NSLocale preferredLanguages].firstObject;
    if ([language hasPrefix:@"en"]) {
        language = @"en";
    } else if ([language hasPrefix:@"zh"]) {
        if ([language rangeOfString:@"Hans"].location != NSNotFound) {
            language = @"zh-Hans"; // 简体中文
        } else { // zh-Hant\zh-HK\zh-TW
            language = @"zh-Hant"; // 繁體中文
        }
    } else {
        language = @"en";
    }
    
    NSString * bundlePathLoc = [bundle pathForResource:language ofType:XYSDKBundle_Loc_Name];
    NSBundle * bundleLoc = [NSBundle bundleWithPath:bundlePathLoc];
    
    return [bundleLoc localizedStringForKey:key value:@"" table:nil];
}

-(UIImage *)getImage:(NSString *)imageName {
    NSString * bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:XYSDKBundle_Name];
    NSBundle * bundle = [NSBundle bundleWithPath:bundlePath];
    UIImage * image = [UIImage imageNamed:imageName inBundle:bundle compatibleWithTraitCollection:nil];
    return image;
}

@end
