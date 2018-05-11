//
//  XYMoreCell.h
//  XYSDK
//
//  Created by 王云刚 on 2018/3/14.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYMoreCell : UITableViewCell {
    UIImageView * _bgImageView; /*背景图片*/
    UIImageView * _desImageView; /*描述图标*/
    UILabel *     _titleLabel; /*标题*/
    UILabel *     _titleDesLabel; /*标题描述*/
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier width:(CGFloat)cellWidth;

@end
