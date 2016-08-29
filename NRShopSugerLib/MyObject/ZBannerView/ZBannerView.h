//
//  ZBannerView.h
//  ZBannerViewDemo
//
//  Created by 张彦东 on 15/12/1.
//  Copyright © 2015年 yd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZBannerView;

@protocol ZBannerViewDelegate <NSObject>

@optional
/**
 *  点击图片后的回调
 *
 *  @param imageIndex 图片Index
 */
- (void)bannerView:(ZBannerView *)bannerView imageDidClickWithIndex:(NSInteger)imageIndex;

@end

@interface ZBannerView : UIView

/**
 *  图片Url数组
 */
@property (nonatomic, copy) NSArray * imageUrls;

@property (nonatomic, weak) id<ZBannerViewDelegate> zbDelegate;


@end
