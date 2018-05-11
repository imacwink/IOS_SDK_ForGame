//
//  XYSessionView.h
//  XYSDK
//
//  Created by 王云刚 on 2018/3/13.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYSessionViewDelegate <NSObject>
-(void)sessionViewCloseAction; /*关闭按钮回调函数*/

@optional
-(void)sessionViewSendAction:(NSString *)inputText; /*输入框发送消息*/
-(void)sessionViewWillChangeHeight:(float)height; /*输入框高度发生改变*/
@end

@class XYSessionTopView;
@class XYSessionBottomView;
@interface XYSessionView : UIView {
    XYSessionTopView *           _sessionTopView; /*会话的标题框*/
    XYSessionBottomView *        _sessionBottomView; /*会话的输入区域*/
    UIButton *                   _soundButton; /*音效按钮*/
    UITableView *                _tableView; /*聊天会话*/
}

@property (nonatomic, assign)id<XYSessionViewDelegate> delegate;

-(id)initWithFrame:(CGRect)frame;

-(void)closeKeyboard; /*关闭键盘*/
-(void)openKeyboard; /*打开键盘*/
-(BOOL)isKeyboardOpen; /*键盘是够打开*/
-(void)clearText; /*清理输入框*/

@end
