//
//  NSDate+CustomAdd.m
//  NRCGlobalShop
//
//  Created by suger on 16/9/16.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import "NSDate+CustomAdd.h"
#import "YYKit.h"

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




- (NSString *)weekDayStr {
    
    NSInteger day = [self weekday];
    NSString* weekDay = nil;
    switch (day) {
        case 1: {
            weekDay = @"周日";
            break;
        }
        case 2:{
            weekDay = @"周一";
            break;
        }
        case 3:{
            weekDay = @"周二";
            break;
        }
        case 4:{
            weekDay = @"周三";
            break;
        }
        case 5:{
            weekDay = @"周四";
            break;
        }
        case 6:{
            weekDay = @"周五";
            break;
        }
        case 7:{
            weekDay = @"周六";
            break;
        }
    }
    return weekDay;
}



- (NSString *)monthDayStr {
    NSInteger day = [self month];
    NSString* monthDay = nil;
    switch (day) {
        case 1: {
            monthDay = @"一月";
            break;
        }
        case 2:{
            monthDay = @"二月";
            break;
        }
        case 3:{
            monthDay = @"三月";
            break;
        }
        case 4:{
            monthDay = @"四月";
            break;
        }
        case 5:{
            monthDay = @"五月";
            break;
        }
        case 6:{
            monthDay = @"六月";
            break;
        }
        case 7:{
            monthDay = @"七月";
            break;
        }
        case 8: {
            monthDay = @"八月";
            break;
        }
        case 9:{
            monthDay = @"九月";
            break;
        }
        case 10:{
            monthDay = @"十月";
            break;
        }
        case 11:{
            monthDay = @"十一月";
            break;
        }
        case 12:{
            monthDay = @"十二月";
            break;
        }
        

    }
    return monthDay;

}
@end
