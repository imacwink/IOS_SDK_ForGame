//
//  XYRootViewController.h
//  XYSDK
//
//  Created by 王云刚 on 2018/3/13.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYRootViewControllerDelegate <NSObject>
-(void)closeVCAction;
@end

@class XYProfileView;
@class XYMoreView;
@class XYSessionView;
@interface XYRootViewController : UIViewController {
    XYProfileView *              _profileView;  /*个人详情页*/
    XYMoreView *                 _moreView;  /*更多详情*/
    XYSessionView *              _sessionView; /*会话试图*/
}

@property (nonatomic, assign)id<XYRootViewControllerDelegate> delegate;

@end
