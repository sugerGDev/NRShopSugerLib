//
//  UILabel+CustomAdd.m
//  NRCGlobalShop
//
//  Created by Sugar on 16/9/3.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import "UILabel+CustomAdd.h"

@implementation UILabel (CustomAdd)
- (void)decoratePriceFromPrice:(NSString *)price  BigFont:(UIFont *)bFont
                       MedFont:(UIFont *)mFont SmlFont:(UIFont *)sFont{
    
    NSString *ePrice = [NSString stringWithFormat:@"%@",price];
    price = [NSString stringWithFormat:@"¥ %@",price];
    
    NSString *str = [NSString stringWithFormat:@"%@",price];
    NSMutableAttributedString *mutlAttriStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    //增加小字体
    NSRange range = [str rangeOfString:price];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:sFont range:range];
    
    [mutlAttriStr addAttribute:NSForegroundColorAttributeName
                         value:[UIColor colorWithRed:0.898 green:0.192 blue:0.384 alpha:1.000] range:range];
    
    //增加中号字体
    range = [str rangeOfString:ePrice];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:mFont range:range];
    
    
    self.attributedText = mutlAttriStr;
}


- (void)decoratePriceFromPrice:(NSString *)price
                    atOriginal:(NSString *)oPrice  BigFont:(UIFont *)bFont
                       MedFont:(UIFont *)mFont SmlFont:(UIFont *)sFont{
    
    NSString *ePrice = [NSString stringWithFormat:@"%@",price];
    price = [NSString stringWithFormat:@"¥ %@",price];
    oPrice = [NSString stringWithFormat:@"¥ %@",oPrice];
    
    NSString *str = [NSString stringWithFormat:@"%@ %@",price,oPrice];
    
    //增加删除划线样式
    NSRange range = [str rangeOfString:oPrice];
    
    NSMutableAttributedString *mutlAttriStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:sFont range:range];
    
    [mutlAttriStr addAttribute:NSForegroundColorAttributeName
                         value:[UIColor colorWithWhite:0.557 alpha:1.000] range:range];
    
    [mutlAttriStr addAttribute:NSStrikethroughStyleAttributeName
                         value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    
    //增加小字体
    range = [str rangeOfString:price];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:sFont range:range];
    
    [mutlAttriStr addAttribute:NSForegroundColorAttributeName
                         value:[UIColor colorWithRed:0.898 green:0.192 blue:0.384 alpha:1.000] range:range];
    
    //增加大字体
    range = [str rangeOfString:ePrice];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:mFont range:range];
    
    
    self.attributedText = mutlAttriStr;
}


- (void)decoratePriceFromBegin:(NSString *)bPrice toEnd:(NSString *)ePrice
                    atOriginal:(NSString *)oPrice  BigFont:(UIFont *)bFont
                       MedFont:(UIFont *)mFont SmlFont:(UIFont *)sFont{
    
    oPrice = [NSString stringWithFormat:@"¥%@",oPrice];
    ePrice = [NSString stringWithFormat:@"¥%@～%@",bPrice,ePrice];
    bPrice = [NSString stringWithFormat:@"%ld",(long)[bPrice integerValue]];
    
    NSString *str = [NSString stringWithFormat:@"%@ %@",ePrice,oPrice];
    NSMutableAttributedString *mutlAttriStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    
    //增加删除划线样式
    NSRange range = [str rangeOfString:oPrice];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:sFont range:range];
    
    [mutlAttriStr addAttribute:NSForegroundColorAttributeName
                         value:[UIColor colorWithWhite:0.529 alpha:1.000] range:range];
    
    [mutlAttriStr addAttribute:NSStrikethroughStyleAttributeName
                         value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    
    
    //增加小字体
    range = [str rangeOfString:ePrice];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:sFont range:range];
    
    [mutlAttriStr addAttribute:NSForegroundColorAttributeName
                         value:[UIColor colorWithRed:0.898 green:0.192 blue:0.384 alpha:1.000] range:range];
    
    //增加价格字体
    range = [str rangeOfString:bPrice];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:mFont range:range];
    
    self.attributedText = mutlAttriStr;
}

@end
