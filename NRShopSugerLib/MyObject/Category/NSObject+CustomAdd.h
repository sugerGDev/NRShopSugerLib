//
//  CustomAdd.h
//  NRShopSugerLib
//
//  Created by Sugar on 16/8/27.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^InitBlock)( id aSender);

@interface NSObject  (CustomAdd)
/*!
 *  @brief 创建NSObject对象，可实现 block 实例对象，该对象不可用于外部；
 *  如果要使用该方法的初始对象，使用 return 实例对象
 *  注意 Block 中循环引用问题 ！！！
 *
 *  @param aBlock 指向内部初始化对象返回，不得用于外部；
 *
 *  @return 指向外部初始化对象返回，可用于外部复制
 *
 *  @since 1.0
 */
+ (instancetype)initObjectWithBlock:(InitBlock)aBlock;
/*!
 *  @brief 通过Xib 方式加在 NSObject 对象
 * 可实现 block 实例对象，该对象不可用于外部；
 *  如果要使用该方法的初始对象，使用 return 实例对象
 *  注意 Block 中循环引用问题 ！！！
 *
 *  @param aBlock 指向内部初始化对象返回，不得用于外部；
 *
 *  @return 指向外部初始化对象返回，可用于外部复制
 */
+ (instancetype)xibObjectWithBlock:(InitBlock)aBlock;
@end
