//
//  XYUtils.m
//  XYSDK
//
//  Created by 王云刚 on 2018/3/13.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "XYUtils.h"

@implementation XYUtils

+(UIColor *) colorWithRGB:(NSUInteger)rgb {
    CGFloat r = (CGFloat)( rgb <<  8 >> 24 ) / 255.0f;
    CGFloat g = (CGFloat)( rgb << 16 >> 24 ) / 255.0f;
    CGFloat b = (CGFloat)( rgb & 0xFF ) / 255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0f];
}

@end
