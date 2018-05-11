//
//  XYProfileView.m
//  XYSDK
//
//  Created by 王云刚 on 2018/3/13.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "XYProfileView.h"
#import "XYBundleManager.h"

#define XY_GUIDE_MERGE 6 /*边距*/
#define XY_GUIDE_SIZE  36  /*引导按钮*/
#define XY_MORE_MERGE 14 /*边距*/
#define XY_MORE_SIZE  48  /*更多按钮*/

@interface XYProfileView()

-(void)createSubView;

@end

@implementation XYProfileView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        /*创建子视图*/
        [self createSubView];
    }
    return self;
}

-(void)createSubView {
    /*创建新手引导按钮*/
    if(nil == _guideButton) {
        CGRect guideRect = CGRectMake(self.frame.size.width - XY_GUIDE_SIZE - XY_GUIDE_MERGE, XY_GUIDE_MERGE, XY_GUIDE_SIZE, XY_GUIDE_SIZE);
        _guideButton = [[UIButton alloc] initWithFrame:guideRect];
        _guideButton.backgroundColor = [UIColor redColor];
         [_guideButton addTarget:self action:@selector(guideAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_guideButton];
    }
    
    /*More按钮*/
    if(nil == _moreButton) {
        CGRect moreRect = CGRectMake((self.frame.size.width - XY_MORE_SIZE) / 2,
                                     self.frame.size.height - XY_MORE_SIZE - XY_MORE_MERGE,
                                     XY_MORE_SIZE,
                                     XY_MORE_SIZE);
        _moreButton = [[UIButton alloc] initWithFrame:moreRect];
        _moreButton.backgroundColor = [UIColor redColor];
        [_moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreButton];
    }
}

-(void)guideAction:(UIButton *)sender {
    NSLog(@"%@", @"guideAction");
}

-(void)moreAction:(UIButton *)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(openMoreAction)]) {
        [_delegate openMoreAction];
    }
}

@end
