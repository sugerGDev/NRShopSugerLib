//
//  UIButton+Tap.h
//  NRShopProject
//
//  Created by mihaia on 16/8/17.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *  @brief 点击事件定义
 */
typedef void(^TapActionBlock)( id tapSender);

/*!
 Button 点击事件处理
 */
@interface UIButton (TapAction)

/*!
 *  @brief 对Button加入一个点击事件Block
 *
 *  @param aBlock 点击事件 Block
 *
 *  @since 1.0
 */
- (void)addTapActionBlock:(TapActionBlock)aBlock;

/*!
 *  @warming 一定要在 delloc 执行 -removeAllTapActionBlock
 *  @brief 移除所有Button的点击事件Block
 *  @since 1.0
 */
- (void)removeAllTapActionBlock;

@end



@interface UIButton (BackgroundImage)


/*!
 *  @brief 自适应设置背景图片，类似- (void)setImage:forState: 效果
 *  为了解决 -setSelected 改变选择图片代码便利
 *  一定要设置- setBackgroundImage:forState:
 *
 *  @param aNormalBgImage   正常状态图片
 *  @param aSelectedBgImage 选择状态图片
 *
 *  @return 图片会发生形变，为了图片不会被拉伸，建议获取图片原始size 进行赋值
 *
 *  @since <#1.0#>
 */
- (CGSize)setNormalBgImage:(UIImage *)aNormalBgImage atSetSelectedBgImage:(UIImage *)aSelectedBgImage;

/*!
 *  @brief 调整 Image 和 Title 反方向位置
 *
 *  @param font 当前字体 UIFont 对象
 *
 *  @since version number
 */
- (void)adjustImageWithTitleInOpposingSideByFont:(UIFont *)font;
@end

/*!
 *  @brief 对于 UIView上的Button点击时间进行处理
 *
 *  @since <#1.0#>
 */
@interface UIView (ButtonTapActionRemove)
/*!
 *  @brief 移除当前 UIView 上的所有的 UIButton 点击事件
 *
 *  @since <#1.0#>
 */
- (void)removeAllButtonTapActions;
/*!
 *  @brief 移除当前 UIView 上指定 Button 的点击事件
 *
 *  @param aBtn 指定 Button 对象
 *
 *  @since <#1.0#>
 */
- (void)removeTapActionByButton:(UIButton *)aBtn;
@end
