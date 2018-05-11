//
//  XYMoreCell.m
//  XYSDK
//
//  Created by 王云刚 on 2018/3/14.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "XYMoreCell.h"

#define XY_DES_ICON_SIZE 64 /*描述图标的尺寸*/
#define XY_CELL_LR_MERGE 10 /*CELL左右边距*/
#define XY_CELL_TB_MERGE 5 /*CELL上下边距*/
#define XY_CELL_H 90 /*CELL高度*/
#define XY_TITLE_H 30 /*标题高度*/
#define XY_TITLE_DES_H 30 /*标题高度*/

@implementation XYMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)cellWidth
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor lightGrayColor];
        
        if(nil == _bgImageView) {
            CGRect bkgRect = CGRectMake(XY_CELL_LR_MERGE, XY_CELL_TB_MERGE, (cellWidth - XY_CELL_LR_MERGE * 2), XY_CELL_H);
            _bgImageView = [[UIImageView alloc] initWithFrame:bkgRect];
            _bgImageView.backgroundColor = [UIColor darkGrayColor];
            [self addSubview:_bgImageView];
        }
        
        if(nil == _desImageView) {
            CGRect desIconRect = CGRectMake(10.0f, (_bgImageView.frame.size.height - XY_DES_ICON_SIZE) / 2, XY_DES_ICON_SIZE, XY_DES_ICON_SIZE);
            _desImageView = [[UIImageView alloc] initWithFrame:desIconRect];
            _desImageView.backgroundColor = [UIColor redColor];
            [_bgImageView addSubview:_desImageView];
        }
        
        if(nil == _titleLabel) {
            CGRect titleRect = CGRectMake(XY_CELL_LR_MERGE + XY_DES_ICON_SIZE + XY_CELL_LR_MERGE / 2,
                                          (_bgImageView.frame.size.height - XY_DES_ICON_SIZE) / 2 + (XY_DES_ICON_SIZE - XY_TITLE_H * 2) / 2 + 4,
                                          cellWidth - XY_CELL_LR_MERGE * 2 - XY_DES_ICON_SIZE,
                                          XY_TITLE_H);
            _titleLabel = [[UILabel alloc] initWithFrame:titleRect];
            _titleLabel.text = @"自助工具";
            _titleLabel.textColor = [UIColor blackColor];
            _titleLabel.font = [UIFont systemFontOfSize:16];
            _titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_titleLabel];
        }
        
        if(nil == _titleDesLabel) {
            CGRect titleDesRect = CGRectMake(XY_CELL_LR_MERGE + XY_DES_ICON_SIZE + XY_CELL_LR_MERGE / 2,
                                          (_bgImageView.frame.size.height - XY_DES_ICON_SIZE) / 2 + XY_TITLE_H + (XY_DES_ICON_SIZE - XY_TITLE_H * 2) / 2,
                                          cellWidth - XY_CELL_LR_MERGE * 2 - XY_DES_ICON_SIZE,
                                          XY_TITLE_H);
            _titleDesLabel = [[UILabel alloc] initWithFrame:titleDesRect];
            _titleDesLabel.text = @"查询金币、铜币流水";
            _titleDesLabel.textColor = [UIColor whiteColor];
            _titleDesLabel.font = [UIFont systemFontOfSize:12];
            _titleDesLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:_titleDesLabel];
        }
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if(_bgImageView) {
        if(selected) {
            _bgImageView.backgroundColor = [UIColor blackColor];
        } else {
            _bgImageView.backgroundColor = [UIColor darkGrayColor];
        }
    }
}

@end
