//
//  XYSessionTopView.m
//  XYSDK
//
//  Created by 王云刚 on 2018/3/13.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "XYSessionTopView.h"

#define XY_CLOSE_RIGHT_MERGE 20
#define XY_CLOSE_SIZE 36

@implementation XYSessionTopView

@synthesize delegate = _delegate;

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        /*显示背景图*/
        if(nil == _bkgImageView) {
            CGRect bkgRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            _bkgImageView = [[UIImageView alloc] initWithFrame:bkgRect];
            _bkgImageView.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:_bkgImageView];
        }
        
        /*显示Title*/
        if(nil == _titleLabel) {
            CGRect titleRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
            _titleLabel = [[UILabel alloc] initWithFrame:titleRect];
            _titleLabel.text = @"游戏SDK";
            _titleLabel.textColor = [UIColor whiteColor];
            _titleLabel.font = [UIFont systemFontOfSize:17];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_titleLabel];
        }
        
        /*显示关闭按钮*/
        if(nil == _closeButton) {
             CGRect closeRect = CGRectMake(self.frame.size.width - XY_CLOSE_SIZE - XY_CLOSE_RIGHT_MERGE,
                                           (self.frame.size.height - XY_CLOSE_SIZE) / 2,
                                           XY_CLOSE_SIZE,
                                           XY_CLOSE_SIZE);
            _closeButton = [[UIButton alloc] initWithFrame:closeRect];
            _closeButton.backgroundColor = [UIColor redColor];
            [_closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_closeButton];
        }
    }
    return self;
}

-(void)closeButtonAction:(UIButton *)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(sessionTopViewCloseAction)]) {
        [_delegate sessionTopViewCloseAction];
    }
}

@end
