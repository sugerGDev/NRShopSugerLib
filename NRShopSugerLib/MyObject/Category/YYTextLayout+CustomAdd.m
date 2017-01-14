//
//  YYTextLayout+CustomAdd.m
//  NRCGlobalShop
//
//  Created by suger on 2016/12/12.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import "YYTextLayout+CustomAdd.h"

@implementation YYTextLayout (CustomAdd)

+ (YYTextLayout *)createMultOrderListTitleString:(NSString *)orgin atHeadlineString:(NSString *)headLine {
    
    
    if (orgin.length == 0) {
        return nil;
    }
    
    NSMutableAttributedString* headlineMutableAttrStr = nil;
    
    if (headLine.length) {
        NSString* formatStateStr = [NSString stringWithFormat:@"   %@",headLine];
        headlineMutableAttrStr = [[NSMutableAttributedString alloc]initWithString:formatStateStr];
        UIColor* color = [UIColor colorWithHexString:@"FF2D4B"];
        
        headlineMutableAttrStr.font = [UIFont systemFontOfSize:11];
        headlineMutableAttrStr.color = color;
        
        YYTextBorder *border = [YYTextBorder new];
        border.cornerRadius = 5;
        border.insets = UIEdgeInsetsMake(-1, 5, -1, -5);
        border.strokeWidth = 0.7;
        border.strokeColor = color;
        border.lineStyle = YYTextLineStyleSingle;
        headlineMutableAttrStr.textBackgroundBorder = border;
    }
    
    
    NSMutableAttributedString* orginalMutableAttrStr  = nil;
    NSMutableAttributedString* titleLabel = nil;
    
    if (headlineMutableAttrStr.length) {
        NSString* str = [NSString stringWithFormat:@"   %@",orgin];
        orginalMutableAttrStr = [[NSMutableAttributedString alloc]initWithString:str];
        orginalMutableAttrStr.font = [UIFont systemFontOfSize:13];
        orginalMutableAttrStr.color = [UIColor colorWithHexString:@"333333"];
        [headlineMutableAttrStr appendAttributedString:orginalMutableAttrStr];
        titleLabel = headlineMutableAttrStr;
        
    }else{
        orginalMutableAttrStr = [[NSMutableAttributedString alloc]initWithString:orgin];
        orginalMutableAttrStr.font = [UIFont systemFontOfSize:13];
        orginalMutableAttrStr.color = [UIColor colorWithHexString:@"333333"];
        titleLabel = orginalMutableAttrStr;
    }
    
    // Generate a text layout.
    // Create text container
    YYTextContainer *container = [YYTextContainer new];
    container.size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 120, CGFLOAT_MAX);
    container.maximumNumberOfRows = 2;
    
    return  [YYTextLayout layoutWithContainer:container text:titleLabel];
}



+ (YYTextLayout *)createMultGroupListTitleString:(NSString *)orgin atHeadlineString:(NSString *)headLine  {
    
    NSMutableAttributedString* headlineMutableAttrStr = nil;
    
    if (headLine.length) {
        NSString* formatStateStr = [NSString stringWithFormat:@"   %@",headLine];
        headlineMutableAttrStr = [[NSMutableAttributedString alloc]initWithString:formatStateStr];
        
        headlineMutableAttrStr.font = [UIFont systemFontOfSize:10];
        headlineMutableAttrStr.color = UIColorHex(ffffff);
        
        YYTextBorder *border = [YYTextBorder borderWithFillColor: UIColorHex(33CC99) cornerRadius:5];
        border.insets = UIEdgeInsetsMake(-2, 4, -2, -5);
//        border.strokeWidth = 0.7;
//        border.strokeColor = color;
//        border.lineStyle = YYTextLineStyleSingle;
        headlineMutableAttrStr.textBackgroundBorder = border;
    }
    
    
    NSMutableAttributedString* orginalMutableAttrStr  = nil;
    NSMutableAttributedString* titleLabel = nil;
    
    if (headlineMutableAttrStr.length) {
        NSString* str = [NSString stringWithFormat:@"   %@",orgin];
        orginalMutableAttrStr = [[NSMutableAttributedString alloc]initWithString:str];
        orginalMutableAttrStr.font = [UIFont systemFontOfSize:15];
        orginalMutableAttrStr.color = [UIColor colorWithHexString:@"333333"];
        [headlineMutableAttrStr appendAttributedString:orginalMutableAttrStr];
        titleLabel = headlineMutableAttrStr;
        
    }else{
        orginalMutableAttrStr = [[NSMutableAttributedString alloc]initWithString:orgin];
        orginalMutableAttrStr.font = [UIFont systemFontOfSize:15];
        orginalMutableAttrStr.color = [UIColor colorWithHexString:@"333333"];
        titleLabel = orginalMutableAttrStr;
    }
    
    // Generate a text layout.
    // Create text container
    YYTextContainer *container = [YYTextContainer new];
    CGFloat w = [UIScreen mainScreen].bounds.size.width - 30;
    container.size = CGSizeMake( w , CGFLOAT_MAX);
    container.maximumNumberOfRows = 2;
    
    return  [YYTextLayout layoutWithContainer:container text:titleLabel];
}
@end
