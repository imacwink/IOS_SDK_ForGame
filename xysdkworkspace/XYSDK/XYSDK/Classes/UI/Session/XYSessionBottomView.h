//
//  XYSessionBottomView.h
//  XYSDK
//
//  Created by 王云刚 on 2018/3/13.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol XYSessionBottomViewDelegate <NSObject>

-(void)sendAction:(NSString *)inputText; /*发送按钮被点击*/
-(void)keyboardShowAction:(CGFloat)diffHight; /*view的大小发生变化*/

@end

@class XYTextView;
@interface XYSessionBottomView : UIView {
    UIImageView *                        _bgImageView; /*背景图片*/
    XYTextView *                         _textView; /*输入框*/
    UIButton *                           _changeInputModelButton; /*输入切换按钮*/
    UIButton *                           _audioButton; /*语音按钮*/
    BOOL                                 _isKeyboardOpen; /*键盘是否打开*/
    NSString *                           _placeholder;
    NSString *                           _lastText;
    CGFloat                              _superHight;
    CGFloat                              _textViewY;
    CGRect                               _originalFrame;
}

@property (nonatomic, assign)id<XYSessionBottomViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame parentView:(UIView *)view;

-(void)closeKeyboard; /*关闭键盘*/
-(void)openKeyboard; /*打开键盘*/
-(BOOL)isKeyboardOpen; /*键盘是够打开*/
-(void)clearText; /*清理输入框*/

@end
