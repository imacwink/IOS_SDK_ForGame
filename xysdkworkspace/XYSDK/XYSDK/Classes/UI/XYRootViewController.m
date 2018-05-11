//
//  XYRootViewController.m
//  XYSDK
//
//  Created by 王云刚 on 2018/3/13.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "XYRootViewController.h"
#import "XYProfileView.h"
#import "XYSessionView.h"
#import "XYMoreView.h"

#define XY_PROFILE_W 220.0

@interface XYRootViewController () <XYSessionViewDelegate, XYProfileViewDelegate, XYMoreViewDelegate, UIGestureRecognizerDelegate>

-(void)createProfileView;
-(void)createSessionView;
-(void)createMoreView;
-(void)registerNotification;
-(void)removeNotification;

@end

@implementation XYRootViewController

@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*事件注册*/
    [self removeNotification];
    [self registerNotification];
    
    /*给整个视图添加手势*/
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tablehandlePanFrom:)];
    [self.view addGestureRecognizer:tapRecognizer];
    tapRecognizer.delegate = self;
    
    /*设置背景颜色*/
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*创建个人详情页面*/
    [self createProfileView];
    
    /*创建会话页面*/
    [self createSessionView];
    
    /*创建More页面*/
    [self createMoreView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Event
-(void)registerNotification {
    // 注册对键盘事件的响应;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)removeNotification {
    // 注销对键盘事件的响应;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - UI Create
-(void)createProfileView {
    if(nil == _profileView) {
        CGRect profileRect = CGRectMake(0.0, 0.0, XY_PROFILE_W, self.view.bounds.size.height);
        _profileView = [[XYProfileView alloc] initWithFrame:profileRect];
        _profileView.delegate = self;
        [self.view addSubview:_profileView];
    }
}

-(void)createSessionView {
    if(nil == _sessionView) {
        CGRect sessionRect = CGRectMake(XY_PROFILE_W, 0.0, self.view.bounds.size.width - XY_PROFILE_W, self.view.bounds.size.height);
        _sessionView = [[XYSessionView alloc] initWithFrame:sessionRect];
        _sessionView.delegate = self;
        [self.view addSubview:_sessionView];
    }
}

-(void)createMoreView {
    if(nil == _moreView) {
        CGRect moreRect = CGRectMake(-XY_PROFILE_W, 0.0, XY_PROFILE_W, self.view.bounds.size.height);
        _moreView = [[XYMoreView alloc] initWithFrame:moreRect];
        _moreView.delegate = self;
        [self.view addSubview:_moreView];
    }
}

#pragma mark - XYSessionViewDelegate

-(void)sessionViewCloseAction {
    if(_delegate && [_delegate respondsToSelector:@selector(closeVCAction)]) {
        [_delegate closeVCAction];
    }
}

-(void)sessionViewSendAction:(NSString *)inputText {
    NSLog(@"sessionViewSendAction : %@", inputText);
    [_sessionView clearText];
}

-(void)sessionViewWillChangeHeight:(float)height {
    NSLog(@"sessionViewWillChangeHeight : %f", height);
}

#pragma mark - XYProfileViewDelegate

-(void)openMoreAction {
    //NSLog(@"%@", @"openMoreAction");
    
    //[_moreView setHidden:NO];
    
    [UIView animateWithDuration:0.3f animations:^{
        _moreView.frame = CGRectMake(0.0, 0.0, XY_PROFILE_W, self.view.bounds.size.height);
    }];
}

#pragma mark - XYMoreViewDelegate

-(void)closeMoreAction {
    //NSLog(@"%@", @"closeMoreAction");
    
    //[_moreView setHidden:YES];
    
    [UIView animateWithDuration:0.3f animations:^{
        _moreView.frame = CGRectMake(-XY_PROFILE_W, 0.0, XY_PROFILE_W, self.view.bounds.size.height);
    }];
}

#pragma mark - KeyBoard callback
-(void)keyBoardWasShown:(NSNotification*)notify {
    NSDictionary * info = [notify userInfo];
    CGRect keyboardEndFrame;
    [[info objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    //NSLog(@"keyBoardWasShown H : %f : %f", keyboardEndFrame.size.height, self.view.frame.origin.y);

    CGFloat ty = keyboardEndFrame.origin.y - [UIScreen mainScreen].bounds.size.height;
    CGFloat duration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
}

-(void)keyBoardWasHidden:(NSNotification*)notify {
    NSDictionary * info = [notify userInfo];
    CGRect keyboardEndFrame;
    [[info objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    //NSLog(@"keyBoardWasHidden H : %f", keyboardEndFrame.size.height);
    
    CGFloat ty = keyboardEndFrame.origin.y - [UIScreen mainScreen].bounds.size.height;
    CGFloat duration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, -ty);
    }];
}

#pragma mark - gesture callback
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    BOOL retValue = NO;
    
    if([_sessionView isKeyboardOpen]) {
        [_sessionView closeKeyboard];
        retValue = YES;
    }
    
    return retValue;
}

-(void)tablehandlePanFrom:(UITapGestureRecognizer *)recognizer
{
}
@end
