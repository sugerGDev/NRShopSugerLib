//
//  UILabel+CustomAdd.m
//  NRCGlobalShop
//
//  Created by Sugar on 16/9/3.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import "UILabel+CustomAdd.h"
#import  <YYKit/YYKit.h>

@implementation UILabel (CustomAdd)
- (void)decoratePriceFromPrice:(NSString *)price  BigFont:(UIFont *)bFont
                       MedFont:(UIFont *)mFont SmlFont:(UIFont *)sFont{
    
    NSString *ePrice = [NSString stringWithFormat:@"%.2f",price.floatValue];
    price = [NSString stringWithFormat:@"¥ %.2f",price.floatValue];
    
    NSString *str = [NSString stringWithFormat:@"%@",price];
    NSMutableAttributedString *mutlAttriStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    //增加小字体
    NSRange range = [str rangeOfString:price];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:sFont range:range];
    
    [mutlAttriStr addAttribute:NSForegroundColorAttributeName
                         value:[UIColor colorWithHexString:@"FF2D4B"] range:range];
    
    //增加中号字体
    range = [str rangeOfString:ePrice];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:mFont range:range];
    
    
    self.attributedText = mutlAttriStr;

}


- (void)decoratePriceFromPrice:(NSString *)price
                    atOriginal:(NSString *)oPrice BigFont:(UIFont *)bFont
                       MedFont:(UIFont *)mFont SmlFont:(UIFont *)sFont{
    
    NSString *ePrice = [NSString stringWithFormat:@"%.2f",price.floatValue];
    price = [NSString stringWithFormat:@"¥%.2f",price.floatValue];
    
    if ( oPrice.length ) {
        oPrice = [NSString stringWithFormat:@"¥%.2f",oPrice.floatValue];
    }
    
    NSString *str = [NSString stringWithFormat:@"%@ %@",price,oPrice];
    
    //增加删除划线样式
    NSRange range = [str rangeOfString:oPrice  options:NSBackwardsSearch];
    
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
                         value:UIColorHex(FF2D4B) range:range];
    
    //增加大字体
    range = [str rangeOfString:ePrice];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:mFont range:range];
    
    
    self.attributedText = mutlAttriStr;
}



- (void)decorateDetailPriceFromPrice:(NSString *)price
                    atOriginal:(NSString *)oPrice
                             MedFont:(UIFont *)mFont MedTxtColor:(UIColor *)mTxtColor
                             SmlFont:(UIFont *)sFont SmlTxtColor:(UIColor *)sTxtColor{
    
    NSString *ePrice = [NSString stringWithFormat:@"%.2f",price.floatValue];
    price = [NSString stringWithFormat:@"¥ %.2f",price.floatValue];
    
    if ( oPrice.length ) {
        oPrice = [NSString stringWithFormat:@"¥ %.2f",oPrice.floatValue];
    }
    
    NSString *str = [NSString stringWithFormat:@"%@ %@",price,oPrice];
    
    //增加删除划线样式
    NSRange range = [str rangeOfString:oPrice  options:NSBackwardsSearch];
    
    NSMutableAttributedString *mutlAttriStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:sFont range:range];
    
    [mutlAttriStr addAttribute:NSForegroundColorAttributeName
                         value:sTxtColor range:range];
    
    [mutlAttriStr addAttribute:NSStrikethroughStyleAttributeName
                         value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    
    //增加¥ 变小 字体
    range = [str rangeOfString:price];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:sFont range:range];
    
    [mutlAttriStr addAttribute:NSForegroundColorAttributeName
                         value:mTxtColor range:range];
    
    //增加大字体
    range = [str rangeOfString:ePrice];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:mFont range:range];
    
    
    self.attributedText = mutlAttriStr;
}


- (void)decorateSalePriceFromPrice:(NSString *)price
                          atOriginal:(NSString *)oPrice BigFont:(UIFont *)bFont
                             MedFont:(UIFont *)mFont SmlFont:(UIFont *)sFont{
    
    NSString *ePrice = [NSString stringWithFormat:@"%.2f",price.floatValue];
    price = [NSString stringWithFormat:@"¥ %.2f",price.floatValue];
    
    if ( oPrice.length ) {
        oPrice = [NSString stringWithFormat:@"¥ %.2f",oPrice.floatValue];
    }
    
    NSString *str = [NSString stringWithFormat:@"%@ %@",price,oPrice];
    
    //增加删除划线样式
    NSRange range = [str rangeOfString:oPrice  options:NSBackwardsSearch];
    
    NSMutableAttributedString *mutlAttriStr = [[NSMutableAttributedString alloc]initWithString:str];
    
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:sFont range:range];
    
    [mutlAttriStr addAttribute:NSForegroundColorAttributeName
                         value:[UIColor colorWithWhite:0.600 alpha:1.000] range:range];
    
    [mutlAttriStr addAttribute:NSStrikethroughStyleAttributeName
                         value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    
    //增加小字体
    range = [str rangeOfString:price];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:M_IntervalFont range:range];
    
    [mutlAttriStr addAttribute:NSForegroundColorAttributeName
                         value:[UIColor colorWithHexString:@"FF2D4B"] range:range];
    
    //增加大字体
    range = [str rangeOfString:ePrice];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:mFont range:range];
    
    
    self.attributedText = mutlAttriStr;
}



- (void)decoratePriceFromBegin:(NSString *)bPrice toEnd:(NSString *)ePrice
                    atOriginal:(NSString *)oPrice  BigFont:(UIFont *)bFont
                       MedFont:(UIFont *)mFont SmlFont:(UIFont *)sFont{
    
    oPrice = [NSString stringWithFormat:@"¥%.2f",oPrice.floatValue];
    ePrice = [NSString stringWithFormat:@"¥%.2f～%.2f",bPrice.floatValue,ePrice.floatValue];
    bPrice = [NSString stringWithFormat:@"%d",[bPrice intValue]];
    
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
                         value:UIColorHex(FF2D4B) range:range];
    
    //增加价格字体
    range = [str rangeOfString:bPrice];
    [mutlAttriStr addAttribute:NSFontAttributeName
                         value:mFont range:range];
    
    self.attributedText = mutlAttriStr;
}

@end

