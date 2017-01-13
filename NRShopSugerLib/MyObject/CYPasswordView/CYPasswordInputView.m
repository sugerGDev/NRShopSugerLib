//
//  CYPasswordInputView.m
//  CYPasswordViewDemo
//
//  Created by cheny on 15/10/8.
//  Copyright © 2015年 zhssit. All rights reserved.
//

#import "CYPasswordInputView.h"
#import "CYConst.h"
#import "UIView+Extension.h"

#define kNumCount 6

@interface CYPasswordInputView ()

/** 保存用户输入的数字集合 */
@property (nonatomic, strong) NSMutableArray *inputNumArray;
/** 关闭按钮 */
@property (nonatomic, weak) UIButton *btnClose;
/** 忘记密码 */
@property (nonatomic, weak) UIButton *btnForgetPWD;

@end

@implementation CYPasswordInputView

#pragma mark  - 生命周期方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupInit];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupInit];
    }
    return self;
}

- (void) setupInit{
    self.isAddCloseBtn = YES;
    self.isShowBackgroundImage = YES;
    self.backgroundColor = [UIColor clearColor];
    /** 注册通知 */
    [self setupNotification];
    /** 添加子控件 */
    [self setupSubViews];
}

-(void)setIsAddCloseBtn:(BOOL)isAddCloseBtn {
    //移除关闭按钮
    if (NO == isAddCloseBtn) {
        
        [self.btnClose removeTarget:self action:@selector(btnClose_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.btnClose removeFromSuperview];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置关闭按钮的坐标
    self.btnClose.width = CYPasswordViewCloseButtonWH;
    self.btnClose.height = CYPasswordViewCloseButtonWH;
    self.btnClose.x = CYPasswordViewCloseButtonMarginLeft;
    self.btnClose.centerY = CYPasswordViewTitleHeight * 0.5;

    // 设置忘记密码按钮的坐标
    self.btnForgetPWD.x = CYScreenWith - (CYScreenWith - CYPasswordViewTextFieldWidth) * 0.5 - self.btnForgetPWD.width;
    self.btnForgetPWD.y = CYPasswordViewTitleHeight + CYPasswordViewTextFieldMarginTop + CYPasswordViewTextFieldHeight + CYPasswordViewForgetPWDButtonMarginTop;
}

- (void)dealloc
{
    CYLog(@"cy =========== %@：我走了", [self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 添加子控件 */
- (void)setupSubViews
{
    /** 关闭按钮 */
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btnCancel];
    [btnCancel setImage:[UIImage imageNamed:CYPasswordViewSrcName(@"password_close")] forState:UIControlStateNormal];
    [btnCancel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.btnClose = btnCancel;
    [self.btnClose addTarget:self action:@selector(btnClose_Click:) forControlEvents:UIControlEventTouchUpInside];

//    /** 忘记密码按钮 */
//    UIButton *btnForgetPWD = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self addSubview:btnForgetPWD];
//    [btnForgetPWD setTitle:@"忘记密码？" forState:UIControlStateNormal];
//    [btnForgetPWD setTitleColor:CYColor(0, 125, 227) forState:UIControlStateNormal];
//    btnForgetPWD.titleLabel.font = CYFont(13);
//    [btnForgetPWD sizeToFit];
//    self.btnForgetPWD = btnForgetPWD;
//    [self.btnForgetPWD addTarget:self action:@selector(btnForgetPWD_Click:) forControlEvents:UIControlEventTouchUpInside];
}

/** 注册通知 */
- (void)setupNotification {
  
    [CYNotificationCenter addObserver:self selector:@selector(disEnalbeCloseButton:) name:CYPasswordViewDisEnabledUserInteractionNotification object:nil];
    [CYNotificationCenter addObserver:self selector:@selector(disEnalbeCloseButton:) name:CYPasswordViewEnabledUserInteractionNotification object:nil];
}

// 按钮点击
- (void)btnClose_Click:(UIButton *)sender {
    [CYNotificationCenter postNotificationName:CYPasswordViewCancleButtonClickNotification object:self];
    [self.inputNumArray removeAllObjects];
}

- (void)btnForgetPWD_Click:(UIButton *)sender {
    [CYNotificationCenter postNotificationName:CYPasswordViewForgetPWDButtonClickNotification object:self];
}

- (void) disEnalbeCloseButton:(NSNotification *)notification{
    BOOL flag = [[notification.object valueForKeyPath:@"enable"] boolValue];
    self.btnClose.userInteractionEnabled = flag;
    self.btnForgetPWD.userInteractionEnabled = flag;
}

- (void)drawRect:(CGRect)rect {
    // 画图
    if (_isShowBackgroundImage) {
        UIImage *imgBackground = [UIImage imageNamed:CYPasswordViewSrcName(@"password_background")];
        [imgBackground drawInRect:rect];
    }
    
    UIImage *imgTextfield = [UIImage imageNamed:CYPasswordViewSrcName(@"password_textfield")];


    CGFloat textfieldY = CYPasswordViewTitleHeight + CYPasswordViewTextFieldMarginTop;
    CGFloat textfieldW = CYPasswordViewTextFieldWidth;
    CGFloat textfieldX = (CYScreenWith - textfieldW) * 0.5;
    CGFloat textfieldH = CYPasswordViewTextFieldHeight;
    [imgTextfield drawInRect:CGRectMake(textfieldX, textfieldY, textfieldW, textfieldH)];

    // 画标题
    NSString *title = self.title ? self.title : @"输入交易密码";

    NSDictionary *arrts = @{NSFontAttributeName:CYFontB(18)};
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:arrts context:nil].size;
    CGFloat titleW = size.width;
    CGFloat titleH = size.height;
    CGFloat titleX = (self.width - titleW) * 0.5;
    CGFloat titleY = (CYPasswordViewTitleHeight - titleH) * 0.5;
    CGRect titleRect = CGRectMake(titleX, titleY, titleW, titleH);

    if (_isShowBackgroundImage) {
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = CYFontB(18);
        attr[NSForegroundColorAttributeName] = CYColor(102, 102, 102);
        [title drawInRect:titleRect withAttributes:attr];

    }
    
    // 画点
    UIImage *pointImage = [UIImage imageNamed:CYPasswordViewSrcName(@"password_point")];
    CGFloat pointW = CYPasswordViewPointnWH;
    CGFloat pointH = CYPasswordViewPointnWH;
    CGFloat pointY =  textfieldY + (textfieldH - pointH) * 0.5;
    __block CGFloat pointX;

    // 一个格子的宽度
    CGFloat cellW = textfieldW / kNumCount;
    CGFloat padding = (cellW - pointW) * 0.5;
    [self.inputNumArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        pointX = textfieldX + (2 * idx + 1) * padding + idx * pointW;
        [pointImage drawInRect:CGRectMake(pointX, pointY, pointW, pointH)];
    }];
}

#pragma mark  - 懒加载
- (NSMutableArray *)inputNumArray {
    if (_inputNumArray == nil) {
        _inputNumArray = [NSMutableArray array];
    }
    return _inputNumArray;
}

- (NSString *)inputStr {
    NSMutableString* str = [NSMutableString string];
    for (NSString* i in self.inputNumArray) {
        [str appendString:i];
    }
    return str;
}
#pragma mark  - 私有方法
// 响应用户按下删除键事件
- (void)deleteNumber {
    [self.inputNumArray removeLastObject];
    [self setNeedsDisplay];
}

- (void)deleteAll {
    [self.inputNumArray removeAllObjects];
    [self setNeedsDisplay];
}

// 响应用户按下数字键事件
- (void)setNumber:(NSString *)numObj {
    if (numObj.length >= kNumCount) return;
    [self.inputNumArray addObject:numObj];
    [self setNeedsDisplay];
}

@end
