//
//  XYSessionView.m
//  XYSDK
//
//  Created by 王云刚 on 2018/3/13.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "XYSessionView.h"
#import "XYSessionTopView.h"
#import "XYSessionBottomView.h"
#import "MJRefreshNormalHeader.h"

#define XY_TOP_H 46.0
#define XY_BOTTOM_H 60.0
#define XY_SOUND_SIZE 36.0 /*音效开关尺寸*/
#define XY_SOUND_R_MERGE 6.0 /*音效开关右边距*/

@interface XYSessionView () <XYSessionBottomViewDelegate, XYSessionTopViewDelegate, UITableViewDataSource, UITableViewDelegate>

-(void)createBottomView;
-(void)createTopView;
-(void)createSoundView;
-(void)createSeesionTableView;

@end

@implementation XYSessionView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        /*创建会话列表*/
        [self createSeesionTableView];
        
        /*创建标题栏视图*/
        [self createTopView];
        
        /*创建输入框视图*/
        [self createBottomView];
        
        /*创建音效开关*/
        [self createSoundView];
    }
    return self;
}

-(void)closeKeyboard {
    [_sessionBottomView closeKeyboard];
}

-(void)openKeyboard {
    [_sessionBottomView openKeyboard];
}

-(BOOL)isKeyboardOpen {
    return YES;
}

-(void)clearText {
    [_sessionBottomView clearText];
}

-(void)createSeesionTableView {
    CGRect tableRect = CGRectMake(0, XY_TOP_H, self.frame.size.width, self.frame.size.height - XY_TOP_H - XY_BOTTOM_H);
    _tableView = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:_tableView];
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // TableView 滚动到最后一行;
    NSIndexPath * index = [NSIndexPath indexPathForRow:(10 - 1) inSection:0];
    [_tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

-(void)loadNewData {
    __weak UITableView *tableViewweak = _tableView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [tableViewweak reloadData];
    
    
        // 拿到当前的下拉刷新控件，结束刷新状态
        [tableViewweak.mj_header endRefreshing];
    });
}

-(void)createSoundView {
    if(nil == _soundButton) {
        CGRect soundRect = CGRectMake(self.frame.size.width - XY_SOUND_SIZE - XY_SOUND_R_MERGE,
                                      XY_TOP_H + 4,
                                      XY_SOUND_SIZE,
                                      XY_SOUND_SIZE);
        _soundButton = [[UIButton alloc] initWithFrame:soundRect];
        _soundButton.backgroundColor = [UIColor redColor];
        [_soundButton addTarget:self action:@selector(soundAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_soundButton];
    }
}

-(void)soundAction:(UIButton *)sender {
    NSLog(@"%@", @"soundAction");
}

-(void)createTopView {
    if(nil == _sessionTopView) {
        CGRect sessionTopRect = CGRectMake(0, 0, self.frame.size.width, XY_TOP_H);
        _sessionTopView = [[XYSessionTopView alloc] initWithFrame: sessionTopRect];
        _sessionTopView.delegate = self;
    }
    [self addSubview:_sessionTopView];
}

-(void)createBottomView {
    if(nil == _sessionBottomView) {
        CGRect sessionBottomRect = CGRectMake(0, self.frame.size.height - XY_BOTTOM_H, self.frame.size.width, XY_BOTTOM_H);
        _sessionBottomView = [[XYSessionBottomView alloc] initWithFrame: sessionBottomRect parentView:self];
        _sessionBottomView.delegate = self;
    }
    [self addSubview:_sessionBottomView];
}

#pragma mark - XYSessionTopViewDelegate

-(void)sessionTopViewCloseAction {
    if(_delegate && [_delegate respondsToSelector:@selector(sessionViewCloseAction)]) {
        [_delegate sessionViewCloseAction];
    }
}

#pragma mark - XYSessionBottomViewDelegate

-(void)sendAction:(NSString *)inputText {
    if(_delegate && [_delegate respondsToSelector:@selector(sessionViewSendAction:)]) {
        [_delegate sessionViewSendAction:inputText];
    }
}

-(void)keyboardShowAction:(CGFloat)diffHight {
    if(_delegate && [_delegate respondsToSelector:@selector(sessionViewWillChangeHeight:)]){
        [_delegate sessionViewWillChangeHeight:diffHight];
    }
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end
