//
//  MLImagePickerHUD.m
//  MLPhotoLib
//
//  Created by leisuro on 16/8/9.
//  Copyright © 2016年 Free. All rights reserved.
//

#import "MLImagePickerHUD.h"

@implementation MLImagePickerHUD

+ (void)showMessage:(NSString *)message
{
    [self showMessage:message duration:0.7f];
}

+ (void)showMessage:(NSString *)message atfer:(CGFloat)atfer{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(atfer * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showMessage:message];
    });
}

+ (void)showMessage:(NSString *)message duration:(CGFloat)duration
{
    UIView *hud = [[UIView alloc] init];
    
    CGRect messageFrame = CGRectZero;
    UILabel *messageLbl = [[UILabel alloc] init];
    messageLbl.frame = messageFrame;
    messageLbl.font = [UIFont systemFontOfSize:14];
    messageLbl.textAlignment = NSTextAlignmentCenter;
    messageLbl.textColor = [UIColor whiteColor];
    messageLbl.text = message;
    [hud addSubview:messageLbl];
    [messageLbl sizeToFit];
    // Update
    messageFrame = messageLbl.frame;
    messageFrame.origin.x = 10;
    messageFrame.size.height = 60;
    messageLbl.frame = messageFrame;
    
    hud.frame = CGRectMake(0, 0, messageLbl.frame.size.width + 20, 60);
    hud.layer.cornerRadius = 3.0;
    hud.alpha = 0.0;
    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    hud.center = CGPointMake([UIApplication sharedApplication].keyWindow.center.x, [UIApplication sharedApplication].keyWindow.center.y + 150);
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    
    [UIView animateWithDuration:duration animations:^{
        hud.alpha = 1.0;
    } completion:^(BOOL finished) {
        sleep(1.f);
        [UIView animateWithDuration:duration animations:^{
            hud.alpha = 0.0;
        } completion:^(BOOL finished) {
            [hud removeFromSuperview];
        }];
    }];
}

@end
