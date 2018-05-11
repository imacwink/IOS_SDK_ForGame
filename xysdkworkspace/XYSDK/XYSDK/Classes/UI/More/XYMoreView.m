//
//  XYMoreView.m
//  XYSDK
//
//  Created by 王云刚 on 2018/3/13.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "XYMoreView.h"
#import "XYMoreCell.h"

#define XY_CLOSE_MERGE  10 /*关闭按钮边距*/
#define XY_CLOSE_SIZE  40 /*关闭按钮*/
#define XY_BOTTOM_IMAGEVIEW_H  60 /*关闭高度*/

@interface XYMoreView()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation XYMoreView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        
        if(nil == _tableView) {
            CGRect tableViewRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - XY_BOTTOM_IMAGEVIEW_H);
            _tableView = [[UITableView alloc] initWithFrame:tableViewRect];
            _tableView.backgroundColor = [UIColor lightGrayColor];
            _tableView.delegate = self;
            _tableView.dataSource = self;
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self addSubview:_tableView];
        }
        
        if(nil == _bottomImageView) {
            CGRect bottomRect = CGRectMake(0, self.frame.size.height - XY_BOTTOM_IMAGEVIEW_H, self.frame.size.width, XY_BOTTOM_IMAGEVIEW_H);
            _bottomImageView = [[UIImageView alloc] initWithFrame:bottomRect];
            _bottomImageView.backgroundColor = [UIColor darkGrayColor];
            [self addSubview:_bottomImageView];
        }
        
        if(nil == _closeButton) {
            CGRect closeBtnRect = CGRectMake((self.frame.size.width - XY_CLOSE_SIZE) / 2,
                                             self.frame.size.height - XY_CLOSE_SIZE - XY_CLOSE_MERGE,
                                             XY_CLOSE_SIZE,
                                             XY_CLOSE_SIZE);
            _closeButton = [[UIButton alloc] initWithFrame:closeBtnRect];
            _closeButton.backgroundColor = [UIColor redColor];
            [_closeButton addTarget:self action:@selector(closeViewAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_closeButton];
        }
    }
    return self;
}

-(void)closeViewAction:(UIButton *)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(closeMoreAction)]) {
        [_delegate closeMoreAction];
    }
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell = (UITableViewCell *)[[XYMoreCell alloc] initWithStyle:UITableViewCellSeparatorStyleNone reuseIdentifier:ID width:self.frame.size.width];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"%@", indexPath.row);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
}
@end
