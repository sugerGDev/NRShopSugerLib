//
//  UILabel+CustomAdd.h
//  NRCGlobalShop
//
//  Created by Sugar on 16/9/3.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define M_SmallFont   [UIFont systemFontOfSize:12]
#define M_MediumlFont [UIFont systemFontOfSize:14]
#define M_BigFont     [UIFont systemFontOfSize:30]
//BigFont:(UIFont *)bFont 参数为预留，如需时候再使用
@interface UILabel (CustomAdd)
/*!
 *  @brief 对价格 Label 修饰
 *
 *  @param price 当前价格
 *
 *  @since <#version number#>
 */
- (void)decoratePriceFromPrice:(NSString *)price BigFont:(UIFont *)bFont
                       MedFont:(UIFont *)mFont SmlFont:(UIFont *)sFont ;
/*!
 *  @brief 对价格 Label 修饰
 *
 *  @param price  当前价格
 *  @param oPrice 原始价格
 *
 *  @since <#version number#>
 */
- (void)decoratePriceFromPrice:(NSString *)price atOriginal:(NSString *)oPrice BigFont:(UIFont *)bFont
                       MedFont:(UIFont *)mFont SmlFont:(UIFont *)sFont;

/*!
 *  @brief 对价格 Label 修饰
 *
 *  @param bPrice 当前价格开始区间
 *  @param ePrice 当前价格结束区间
 *  @param oPrice 原始价格
 *
 *  @since <#version number#>
 */
- (void)decoratePriceFromBegin:(NSString *)bPrice toEnd:(NSString *)ePrice
                    atOriginal:(NSString *)oPrice  BigFont:(UIFont *)bFont
                       MedFont:(UIFont *)mFont SmlFont:(UIFont *)sFont;

@end
