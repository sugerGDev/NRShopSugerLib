//
//  CustomAdd.m
//  NRShopSugerLib
//
//  Created by Sugar on 16/8/27.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import "NSObject+CustomAdd.h"


@implementation NSObject(CustomAdd)

+ (instancetype)initObjectWithBlock:(InitBlock)aBlock {

    Class cls = [self class];
    NSObject *innerClass =  [cls new];
    __weak typeof(innerClass) weakSelf = innerClass;
    
    if (innerClass && aBlock) {
        aBlock( weakSelf );
    }
    return weakSelf;
}
@end
