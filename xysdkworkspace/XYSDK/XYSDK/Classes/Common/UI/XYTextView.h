//
//  XYTextView.h
//  XYSDK
//
//  Created by 王云刚 on 2018/3/15.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYTextView : UITextView {
    UILabel * _placeHolderLabel;
}

@property(nullable, nonatomic,copy) IBInspectable NSString  * placeholder;

@end
