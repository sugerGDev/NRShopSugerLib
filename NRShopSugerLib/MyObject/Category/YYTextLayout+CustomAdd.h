//
//  YYTextLayout+CustomAdd.h
//  NRCGlobalShop
//
//  Created by suger on 2016/12/12.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import <YYKit/YYKit.h>

@interface YYTextLayout (CustomAdd)
//适用于订单模块
+ (YYTextLayout *)createMultOrderListTitleString:(NSString *)orgin atHeadlineString:(NSString *)headLine ;


/**
 适用于 首页团购列表

 @param orgin <#orgin description#>
 @param headLine <#headLine description#>
 @return <#return value description#>
 */
+ (YYTextLayout *)createMultGroupListTitleString:(NSString *)orgin atHeadlineString:(NSString *)headLine ;
@end
