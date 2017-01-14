//
//  UIImage+CustomAdd.h
//  NRCGlobalShop
//
//  Created by suger on 16/9/23.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CustomAdd)
- (UIImage *)imageCopy;
- (UIImage *)normalizedImage;
//打水印
- (UIImage *)watermarkWithImage:(UIImage *)maskImage atCenter:(CGPoint)center;
@end
