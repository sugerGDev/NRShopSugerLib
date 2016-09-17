//
//  WBPopMenuView.h
//  QQ_PopMenu_Demo
//
//  Created by suger on 16/3/17.
//  Copyright © 2016年 TeKSun Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBTableViewDataSource.h"
#import "WBTableViewDelegate.h"

typedef NS_ENUM(NSInteger,ENWBPopMenuAlertType)   {
    ENWBPopMenuAlertLeftType = 0,
    ENWBPopMenuAlertMiddleType,
    ENWBPopMenuAlertRightType
};
//隐藏Block
typedef void(^HandlerPopMenuViewBlock)(BOOL isShowing);
#pragma mark -- 弹出框选择
@interface WBPopMenuView : UIView


- (instancetype) initWithFrame:(CGRect)frame
                     menuWidth:(CGFloat)menuWidth
                         items:(NSArray *)items
                        action:(void(^)(NSInteger index))action;



- (instancetype) initWithFrame:(CGRect)frame
                     menuWidth:(CGFloat)menuWidth
                     menuPoint:(CGPoint)menuPoint
                         items:(NSArray *)items
                        action:(void(^)(NSInteger index))action;


/*!
 *  弹出框动画出现位置
 */
@property (nonatomic , assign) ENWBPopMenuAlertType alertType;
/*!
 *  @brief 隐藏Block
 *
 *  @since <#version number#>
 */
@property (nonatomic , copy) HandlerPopMenuViewBlock handlerPopMenuViewBlock;
- (void) hideMenu;
- (void) showMenu;

@end



