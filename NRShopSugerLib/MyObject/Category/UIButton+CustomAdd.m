//
//  UIButton+Tap.m
//  NRShopProject
//
//  Created by mihaia on 16/8/17.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import "UIButton+CustomAdd.h"
#import <objc/runtime.h>


static const int block_key;

#pragma mark - _YYUIButtonBlockTarget
@interface _YYUIButtonBlockTarget : NSObject
@property (nonatomic , copy) TapActionBlock block;

- (instancetype)initWithBlock:(TapActionBlock)block;
- (void)invoke:(id)sender;

@end

@implementation _YYUIButtonBlockTarget

- (instancetype)initWithBlock:(TapActionBlock)block {
    if (self = [super init]) {
        _block = block;
    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) {
        _block(sender);
    }
}
@end

#pragma mark - UIButton+TapAction
@implementation UIButton (TapAction)

#pragma mark - Publice

- (void)addTapActionBlock:(TapActionBlock)aBlock {
    //get targets
    _YYUIButtonBlockTarget *target = [[_YYUIButtonBlockTarget alloc]initWithBlock:aBlock];
    //add target action
    [self addTarget:target
             action:@selector(invoke:)
   forControlEvents:UIControlEventTouchUpInside];
    //save target
    NSMutableArray *targets = [self _yy_allUIButtonBlockTargets];
    [targets addObject:target];
    
}

- (void)removeAllTapActionBlock {
    
    NSMutableArray *targets = [self _yy_allUIButtonBlockTargets];
    for (_YYUIButtonBlockTarget *target in targets) {
        //remove target
        [self removeTarget:target
                    action:@selector(invoke:)
          forControlEvents:UIControlEventTouchUpInside];
    }
    targets = nil;
}

- (NSMutableArray *)_yy_allUIButtonBlockTargets {
    
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (nil == targets) {
        targets = [NSMutableArray arrayWithCapacity:3];
        objc_setAssociatedObject(self, &block_key,
                                 targets,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}


- (CGSize)setNormalBgImage:(UIImage *)aNormalBgImage
      atSetSelectedBgImage:(UIImage *)aSelectedBgImage {
    
    [self setBackgroundImage:aNormalBgImage forState:UIControlStateNormal];
    [self setBackgroundImage:aSelectedBgImage forState:UIControlStateSelected];
    
    CGSize nSize = aNormalBgImage.size;
    CGSize sSize = aSelectedBgImage.size;
    
    CGFloat w = MIN(nSize.width, sSize.width);
    CGFloat h = MIN(nSize.height, sSize.height);
    return CGSizeMake(w, h );
}


@end



@implementation UIButton (BackgroundImage)

- (CGSize)setNormalBgImage:(UIImage *)aNormalBgImage
      atSetSelectedBgImage:(UIImage *)aSelectedBgImage {
    
    [self setBackgroundImage:aNormalBgImage forState:UIControlStateNormal];
    [self setBackgroundImage:aSelectedBgImage forState:UIControlStateSelected];
    
    CGSize nSize = aNormalBgImage.size;
    CGSize sSize = aSelectedBgImage.size;
    
    CGFloat w = MIN(nSize.width, sSize.width);
    CGFloat h = MIN(nSize.height, sSize.height);
    return CGSizeMake(w, h );
}

@end


@implementation UIButton(ButtonTapActionRemove)

- (void)removeAllButtonTapActions {
    for (UIButton *aBtn in self.subviews) {
        if ([aBtn isKindOfClass:[UIButton class]]) {
            [aBtn removeAllTapActionBlock];
        }
    }
}

- (void)removeTapActionByButton:(UIButton *)aBtn {
    
    UIButton* targetBtn = nil;
    for (UIButton *aBtn in self.subviews) {
        if ([aBtn isKindOfClass:[UIButton class]]) {
            if ([targetBtn isEqual:aBtn]) {
                [targetBtn removeAllTapActionBlock];
                break;
            }
        }
    }
}

@end

