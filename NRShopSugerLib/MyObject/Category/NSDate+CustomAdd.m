//
//  NSDate+CustomAdd.m
//  NRCGlobalShop
//
//  Created by suger on 16/9/16.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import "NSDate+CustomAdd.h"

@implementation NSDate (CustomAdd)


+ (NSDate *)dateWithSimpleFormatString:(NSString *)dateString {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    return [formatter dateFromString:dateString];
}
@end
