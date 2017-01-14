//
//  HClTextView.m
//  Kurrent
//
//  Created by hcl on 15/9/14.
//  Copyright (c) 2015年 Kurrent. All rights reserved.
//

#import "HClTextView.h"


@implementation HClTextView

- (void)awakeFromNib {
    [super awakeFromNib];
    _divLineHeight.constant = 1;
}

- (void)setLeftTitleText:(NSString *)text
{
    _leftLabel.text = text;
}

- (void)setTextCountLabelHidden:(BOOL)hidden
{
    _textCountLabel.hidden = hidden;
}

- (void)setBottomDivLineHidden:(BOOL)hidden
{
    _bottomDivLine.hidden = hidden;
}



- (BOOL)isOverflowLimitedTextNum {
    //超出字数范围，并且不能为空
    return !( _textView.text.length > _maxTextCount
             || [_textView.text stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0);
}



- (void)setClearButtonType:(ClearButtonType)clearButtonType
{
    _clearButtonType = clearButtonType;
}






- (IBAction)clearButtonClick:(UIButton *)sender
{
    _textView.text = nil;
}


- (void)setClearButton:(UIButton *)clearButton {
    _clearButton  = clearButton;
    UIImage* img = [UIImage imageNamed:@"HCIResouce.bundle/drip_edit_delete"];
    [_clearButton setImage:img forState:UIControlStateNormal];
}


#pragma mark - YYTextViewDelegate Help
- (void)textViewTextLengthChange:(NSInteger)length
{
    _clearButtonType = ClearButtonAppearWhenEditing;
    
    if ((length == 0 && _clearButtonType == ClearButtonAppearWhenEditing) ||
        _clearButtonType == ClearButtonNeverAppear) {
        _clearButton.hidden = YES;
    }
    else if ((length > 0 && _clearButtonType == ClearButtonAppearWhenEditing) || _clearButtonType == ClearButtonAppearAlways){
        _clearButton.hidden = NO;
    }
    else {
        _clearButton.hidden = YES;
    }
}




#pragma mark - YYTextViewDelegate
- (void)textViewDidChange:(YYTextView *)textView{
    
    [self textViewTextLengthChange:textView.text.length];
    
    
    //获取高亮部分
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    if (!position) {
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制
        _textCountLabel.text = [NSString stringWithFormat:@"%ld/%ld",(long)textView.text.length,(long)_maxTextCount];
    }
    
    if (_textView.text.length > _maxTextCount) {
        _textCountLabel.textColor = [UIColor redColor];
    }
    else {
        _textCountLabel.textColor = [UIColor darkGrayColor];
    }
    
    if ([_delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [_delegate textViewDidChange:textView];
    }
}
- (BOOL)textViewShouldBeginEditing:(YYTextView *)textView {
    if ([_delegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [_delegate textViewShouldBeginEditing:textView];
    }
    return YES;
}

#pragma  mark - layout
- (YYTextView *)textView {
    if (!_textView) {
        _textView = [YYTextView new];
        [self addSubview:_textView];
        
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.textColor = UIColorHex(595959);
        
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(8);
            make.top.equalTo(self.mas_top).offset(8);
            make.right.equalTo(self.mas_right).offset(-15);
            make.bottom.equalTo(self.mas_bottom).offset(-8);
            
        }];
        
        _textView.delegate = self;
        _textView.tintColor = [UIColor colorWithHexString:@"ff2d4b"];
        
    }
    return _textView;
}

@end
