//
//  MBTIMgrTextField.m
//  MBTravel
//
//  Created by suger on 15/12/12.
//  Copyright © 2015年 TeKSun Co. Ltd.. All rights reserved.
//

#import "MBTIMgrTextField.h"
#import  <YYKit/YYKit.h>


@implementation MBTIMgrTextField
#pragma mark - Life Method

- (instancetype)init {
    if (self = [super init]) {
        [self setupInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder] ) {
        [self setupInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupInit];
    }
    return self;
}

- (void)setupInit {
    self.tintColor = [UIColor colorWithHexString:@"ff2d4b"];
    [self setDelegate:self];
    [self setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self setReturnKeyType:UIReturnKeyDone];
    [self setTextColor:UIColorHex(595959)];
    
    //在ip5 以下会出现崩溃的问题，改用通知实现
    //    [self addTarget:self action:@selector(textFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
    //add textFieldValueChange: Observer
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(textFieldValueChange:)
                                                name:UITextFieldTextDidChangeNotification
                                              object:nil];
    self.limitNumber = @20;
    
}


- (void)dealloc {
    [self setDelegate:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - setter
- (void)setIsNeedBankNumSgmentation:(BOOL)isNeedBankNumSgmentation {
    
    if (_isNeedPhoneNumSgmentation) {
        NSLog(@"_isNeedPhoneNumSgmentation is YES");
        return;
    }
    _isNeedBankNumSgmentation  = isNeedBankNumSgmentation;
    if (_isNeedBankNumSgmentation) {
        self.limitNumber = @(19 + 4); //银行卡至多限制在23位内
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
}

- (void)setIsNeedPhoneNumSgmentation:(BOOL)isNeedPhoneNumSgmentation {
    
    if (_isNeedBankNumSgmentation) {
        NSLog(@"_isNeedBankNumSgmentation is YES");
        return;
    }
    _isNeedPhoneNumSgmentation = isNeedPhoneNumSgmentation;
    if (_isNeedPhoneNumSgmentation) {
        self.limitNumber = @(11 + 2); //手机号至多限制在13位内
        self.keyboardType = UIKeyboardTypeNumberPad;
    }
}
#pragma mark - Number Sgmentation

- (BOOL)handlerSgmentationTextField:(UITextField *)textField
      shouldChangeCharactersInRange:(NSRange)range
                  replacementString:(NSString *)string {
    
    //判断是否有Delegate
    if ([_mbDelegate respondsToSelector:@selector(delegateTextFieldValueChange:)]) {
        [_mbDelegate delegateTextFieldValueChange:textField];
    }
    
    
    //不是输入手机号和银行卡号的时候...
    if (_isNeedBankNumSgmentation == NO
        && _isNeedPhoneNumSgmentation == NO) {
        return YES;
    }
    
    
    // 16位以内 (3个空格)
    NSString *str_segmentation = [NSString stringWithFormat:@"%@%@",textField.text,string];
    NSInteger nun =  [self.limitNumber integerValue];
    NSInteger cur =  textField.text.length;
    
    if (cur < nun) {
        //只能输入数字
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"] invertedSet];
        NSString *filterStr = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filterStr];
        if(!basicTest)
        {
            return NO;
        }
        
        //显示内容的格式化
        if(range.length > 0 && str_segmentation.length > 0)// 支持删除
        {
            NSString *tmp_str = [str_segmentation segmentationToNormalNum];
            str_segmentation = [tmp_str substringToIndex:(tmp_str.length - 1)];
        }
        str_segmentation =  self.isNeedBankNumSgmentation ? [str_segmentation normalNumToBankNum] : [str_segmentation normalNumToPhoneNum];
        textField.text = str_segmentation;
        return NO;
    }
    else
    {
        if(range.length > 0 && str_segmentation.length > 0)// 支持删除
        {
            NSString *tmp_str = [str_segmentation segmentationToNormalNum];
            str_segmentation = [tmp_str substringToIndex:(tmp_str.length - 1)];
            str_segmentation =  self.isNeedBankNumSgmentation ? [str_segmentation normalNumToBankNum] : [str_segmentation normalNumToPhoneNum];
            textField.text = str_segmentation;
        }
        return NO;
    }
}

#pragma mark - limit Number Method
- (IBAction)textFieldValueChange:(NSNotification *)aNotification {
    
    UITextField *textField = (UITextField *)aNotification.object;
    if (NO == [textField isEqual:self]) {
        return;
    }
    int limit = [self.limitNumber intValue];
    
    if (textField.text.length >= limit) {
        //限制字符串长度为20
        self.text = [textField.text substringToIndex:(limit - 1)];
        
    }
}

#pragma mark - Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:UIMBTIMgrTextFieldReturnSholdNotification object:self];
  
    return [textField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self handlerSgmentationTextField:textField
               shouldChangeCharactersInRange:range
                           replacementString:string];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([_mbDelegate respondsToSelector:@selector(delegateTextFieldShouldBeginEditing:)]) {
       return [_mbDelegate delegateTextFieldShouldBeginEditing:textField];
    }
    return YES;
}


#pragma mark - Vaild Mehtod
- (BOOL)isValidName {
    return [self.text isChineseAlphabet] && (self.text.length != 0);
}
- (BOOL)isValidPhone {
    
    NSString* str = [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [str isValidMobileNumber] && (str.length != 0);
}
- (BOOL)isEmpty{
    return [self.text isStringEmpty];
}

#pragma mark - Edge
//-------------------设置指定边距大小-------------------

- (void)setEdgeOffsetToLeft:(CGFloat)lOffset {
    self.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, lOffset, CGRectGetHeight(self.frame))];
    self.leftViewMode = UITextFieldViewModeAlways;
}
- (void)setEdgeOffsetToRight:(CGFloat)rOffset {
    self.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, rOffset, CGRectGetHeight(self.frame))];
    self.rightViewMode = UITextFieldViewModeAlways;
}
//-------------------设置指定边距大小-------------------


NSString* const UIMBTIMgrTextFieldReturnSholdNotification = @"UIMBTIMgrTextFieldReturnSholdNotification";

@end
