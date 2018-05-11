//
//  XYMoreView.h
//  XYSDK
//
//  Created by 王云刚 on 2018/3/13.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XYMoreViewDelegate <NSObject>
-(void)closeMoreAction;
@end

@interface XYMoreView : UIView {
    UITableView      * _tableView;
    UIImageView      * _bottomImageView;
    UIButton         * _closeButton;
}

@property (nonatomic, assign)id<XYMoreViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

@end
