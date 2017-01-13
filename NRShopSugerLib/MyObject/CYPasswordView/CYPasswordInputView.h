//
//  CYPasswordInputView.h
//  CYPasswordViewDemo
//
//  Created by cheny on 15/10/8.
//  Copyright © 2015年 zhssit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYPasswordInputView : UIView
@property (nonatomic, copy) NSString *title;
//设置是否背景图
@property (nonatomic , assign) BOOL isShowBackgroundImage;
//是否需要关闭按钮
@property (nonatomic , assign) BOOL isAddCloseBtn;

@property (nonatomic , copy ,readonly) NSString* inputStr;

//删除方法
- (void)deleteNumber;
- (void)deleteAll;

- (void)setNumber:(NSString *)numObj;
@end