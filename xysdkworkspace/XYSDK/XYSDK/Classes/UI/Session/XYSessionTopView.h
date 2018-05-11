//
//  XYSessionTopView.h
//  XYSDK
//
//  Created by 王云刚 on 2018/3/13.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYSessionTopViewDelegate <NSObject>
-(void)sessionTopViewCloseAction; /*关闭按钮回调函数*/
@end

@interface XYSessionTopView : UIView {
    UILabel *      _titleLabel;
    UIImageView *  _bkgImageView;
    UIButton *     _closeButton;
}

@property (nonatomic, assign)id<XYSessionTopViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame;

@end
