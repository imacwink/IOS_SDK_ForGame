//
//  XYSessionBottomView.m
//  XYSDK
//
//  Created by 王云刚 on 2018/3/13.
//  Copyright © 2018年 Tencent. All rights reserved.
//

#import "XYSessionBottomView.h"
#import "XYTextView.h"

#define XY_CHANGE_INPUTMODEL_X_MERGE 13  /*左边切换模式的边距*/
#define XY_CHANGE_INPUTMODEL_SIZE 40 /*切换按钮的宽度和高度*/
#define XY_AUDIO_BUTTON_RIGHT_MERGE 16 /*语音按钮右边边距*/
#define XY_AUDIO_BUTTON_SIZE 66 /*语音按钮宽高*/
#define XY_INPUT_X_MERGE 15  /*输入框左边距*/
#define XY_INPUT_HIGHT 40  /*输入框高度*/
#define XY_INPUT_MAX_HIGHT 80  /*输入框最大高度*/

@interface XYSessionBottomView () <UITextViewDelegate>

-(void)createSubView:(UIView *)parentView;

@end

@implementation XYSessionBottomView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame parentView:(UIView *)view{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        /*创建UI*/
        [self createSubView:view];
    }
    return self;
}

-(void)closeKeyboard {
    _isKeyboardOpen = NO;
    [_textView resignFirstResponder];
}

-(void)openKeyboard {
    _isKeyboardOpen = YES;
    [_textView becomeFirstResponder];
}

-(BOOL)isKeyboardOpen {
    return _isKeyboardOpen;
}

-(void)clearText {
    _textView.text = @"";
}

-(void)createSubView:(UIView *)parentView {
    
    /*背景图片*/
    if(nil == _bgImageView) {
        CGRect bgRect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _bgImageView = [[UIImageView alloc] initWithFrame:bgRect];
        _bgImageView.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:_bgImageView];
    }
    
    /*输入框展示*/
    if(nil == _textView) {        
        _textView = [[XYTextView alloc] init];
        _textView.delegate            = self;
        _textView.placeholder         = _placeholder;
        _textView.backgroundColor     = [UIColor whiteColor];
        _textView.font                = [UIFont systemFontOfSize:17];
        _textView.layer.cornerRadius  = 5;
        _textView.layer.masksToBounds = YES;
        _textView.layer.borderWidth   = 0.5;
        _textView.returnKeyType       = UIReturnKeySend;
        _textView.layer.borderColor   = [[UIColor grayColor] CGColor];
        _textView.layoutManager.allowsNonContiguousLayout = NO;
        [self addSubview:_textView];
        
        CGFloat textViewX = XY_CHANGE_INPUTMODEL_X_MERGE + XY_CHANGE_INPUTMODEL_SIZE + XY_INPUT_X_MERGE;
        CGFloat textViewW = self.frame.size.width - XY_CHANGE_INPUTMODEL_X_MERGE - XY_CHANGE_INPUTMODEL_SIZE - XY_INPUT_X_MERGE * 2;
        CGFloat textViewH = XY_INPUT_HIGHT;
        CGFloat textViewY = (self.frame.size.height - XY_INPUT_HIGHT) / 2;
        
        _textView.frame = CGRectMake(textViewX, textViewY, textViewW, textViewH);
        _textViewY      = textViewY;
        _superHight     = self.frame.size.height;
    }
    
    /*输入切换按钮*/
    if(nil == _changeInputModelButton) {
        CGRect changeInputModelRect = CGRectMake(XY_CHANGE_INPUTMODEL_X_MERGE,
                                                 (self.frame.size.height - XY_CHANGE_INPUTMODEL_SIZE) / 2,
                                                 XY_CHANGE_INPUTMODEL_SIZE,
                                                 XY_CHANGE_INPUTMODEL_SIZE);
        _changeInputModelButton = [[UIButton alloc] initWithFrame:changeInputModelRect];
        _changeInputModelButton.backgroundColor = [UIColor redColor];
        [_changeInputModelButton addTarget:self action:@selector(changeInputModelButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_changeInputModelButton];
    }
    
    /*录音按钮*/
    if(nil == _audioButton) {
        CGRect audioRect = CGRectMake(self.frame.size.width - XY_AUDIO_BUTTON_SIZE - XY_AUDIO_BUTTON_RIGHT_MERGE,
                                      -40,
                                      XY_AUDIO_BUTTON_SIZE,
                                      XY_AUDIO_BUTTON_SIZE);
        _audioButton = [[UIButton alloc] initWithFrame:audioRect];
        _audioButton.backgroundColor = [UIColor redColor];
        [_audioButton addTarget:self action:@selector(startRecordEvent:) forControlEvents:UIControlEventTouchDown];
        [_audioButton addTarget:self action:@selector(recordEndEvent:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
        [self addSubview:_audioButton];
        [_audioButton setHidden:YES];
    }
}

-(void)changeInputModelButtonEvent:(UIButton *)sender {
    if(_audioButton.isHidden) {
        [_audioButton setHidden:NO];
        [_textView setHidden:YES];
    } else {
        [_audioButton setHidden:YES];
        [_textView setHidden:NO];
    }
}

-(void)startRecordEvent:(UIButton *)sender {
    NSLog(@"%@", @"startRecordEvent");
}

-(void)recordEndEvent:(UIButton *)sender {
    NSLog(@"%@", @"recordEndEvent");
}

#pragma mark - UIExpandingTextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    _lastText = @"";
    _textView.placeholder = _placeholder;
}

- (void)textViewDidChange:(UITextView *)textView {
    /*CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    
    if (size.height<=frame.size.height) {
        
    } else {
        if (size.height >= XY_INPUT_MAX_HIGHT) {
            size.height = XY_INPUT_MAX_HIGHT;
            textView.scrollEnabled = YES;   /*允许滚动*/
       /* } else {
            textView.scrollEnabled = NO;    /*不允许滚动*/
       /* }
    }
    
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
    
    CGFloat superHeight = CGRectGetMaxY(textView.frame) + _textViewY;
    
    /*[UIView animateWithDuration:0 animations:^{
        [self setFrame:CGRectMake(self.frame.origin.x, [UIScreen mainScreen].bounds.size.height-(_keyBoardHight+superHeight), self.frame.size.width, superHeight)];
    }];*/
    
    /*CGFloat h = [self heightForString:textView.text fontSize:17];
    if (textView.text.length >_lastText.length + 5) {
        if (h > XY_INPUT_MAX_HIGHT) {
            [textView setContentOffset:CGPointMake(0, (h - XY_INPUT_MAX_HIGHT)) animated:NO];
        }
    }
    _lastText = textView.text;*/
}

-(float)heightForString:(NSString *)value fontSize:(float)fontSize {
    /*NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [value boundingRectWithSize:CGSizeMake(self.frame.size.width - XY_CHANGE_INPUTMODEL_X_MERGE - XY_CHANGE_INPUTMODEL_SIZE - XY_INPUT_X_MERGE * 2 - 20, CGFLOAT_MAX) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return size.height;*/
    return 0;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    /*CGRect r = [textView caretRectForPosition:textView.selectedTextRange.end];
    CGFloat caretY =  MAX(r.origin.y - textView.frame.size.height + r.size.height + 8, 0);
    if (textView.contentOffset.y < caretY && r.origin.y != INFINITY) {
        textView.contentOffset = CGPointMake(0, caretY);
    }*/
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    /*textView.scrollEnabled = NO;
    CGRect frame           = textView.frame;
    textView.frame         = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, XY_INPUT_HIGHT);
    [textView layoutIfNeeded];
    [_textView resignFirstResponder]; */
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]){
        NSCharacterSet * whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString * str = [[NSString alloc]initWithString:[textView.text stringByTrimmingCharactersInSet:whiteSpace]];
        if (str.length != 0) {
            if(_delegate && [_delegate respondsToSelector:@selector(sendAction:)]) {
                [_delegate sendAction:str];
            }
        }
        return NO;
    }
    return YES;
}
@end
