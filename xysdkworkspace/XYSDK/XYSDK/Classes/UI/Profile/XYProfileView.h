//
//  XYProfileView.h
//  XYSDK
//
//  Created by 王云刚 on 2018/3/13.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYProfileViewDelegate <NSObject>
-(void)openMoreAction;
@end

@interface XYProfileView : UIView {
    UIImageView    * _headImageView; /*玩家头像展示*/
    UIButton       * _guideButton; /*新手引导按钮*/
    UIButton       * _moreButton; /*点击查看更多按钮*/
    UILabel        * _hotIssuesLabel; /*热门问题*/
    UIButton       * _changeHotIssuesButton; /*换一批热门问题*/
    UILabel        * _activityLabel; /*热门活动*/
    UIButton       * _changeActivityButton; /*换一批热门活动*/
}

@property (nonatomic, assign)id<XYProfileViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

@end
