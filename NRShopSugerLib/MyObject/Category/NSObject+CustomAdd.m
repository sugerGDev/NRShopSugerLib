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
    
    if (innerClass ) {
        if(aBlock) aBlock( weakSelf );
    }
    return weakSelf;
}

+ (instancetype)xibObjectWithBlock:(InitBlock)aBlock {
    
    NSString* str = NSStringFromClass([self class]);

    NSArray* array = [[NSBundle mainBundle]loadNibNamed:str owner:nil options:nil];
    
    NSObject *innerClass =  array.firstObject;
    __weak typeof(innerClass) weakSelf = innerClass;
    
    if (innerClass) {
      if(aBlock) aBlock( weakSelf );
    }
    return weakSelf;
}
@end
