//
//  HClTextView.h
//  Kurrent
//
//  Created by hcl on 15/9/14.
//  Copyright (c) 2015年 Kurrent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>

#define kWinsize [[UIScreen mainScreen] bounds].size

typedef NS_ENUM(NSUInteger, ClearButtonType) {
    ClearButtonNeverAppear,     // 默认隐藏
    ClearButtonAppearWhenEditing,   // 编辑时显示
    ClearButtonAppearAlways,        // 一直显示
};
@protocol HClTextViewDelegate;

@interface HClTextView : UIView <YYTextViewDelegate> {

    BOOL _isInputFirst;
}

@property (nonatomic,weak) id<HClTextViewDelegate> delegate;
@property (assign, nonatomic) ClearButtonType clearButtonType;
@property (nonatomic,assign) NSUInteger maxTextCount;

@property (strong, nonatomic) YYTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

//是否超出字数限制
@property (nonatomic , assign,readonly) BOOL isOverflowLimitedTextNum;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *divLineHeight;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *textCountLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomDivLine;

///设置左侧Label文字(需优先设置,则会改变部分占位文字)!!!
- (void)setLeftTitleText:(NSString *)text;
///设置是否显示输入字数
- (void)setTextCountLabelHidden:(BOOL)hidden;
///设置是否显示底部分割线
- (void)setBottomDivLineHidden:(BOOL)hidden;



@end

@protocol HClTextViewDelegate <NSObject>
@optional
- (void)textViewDidChange:(YYTextView *)textView;
- (BOOL)textViewShouldBeginEditing:(YYTextView *)textView;
@end
