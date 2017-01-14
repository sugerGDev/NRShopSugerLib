//
//  UIView+MSSLayout.m
//  MSSBrowse
//
//  Created by 于威 on 15/12/5.
//  Copyright © 2015年 于威. All rights reserved.
//

#import "UIView+MSSLayout.h"

@implementation UIView (MSSLayout)


- (void)mss_setFrameInSuperViewCenterWithSize:(CGSize)size
{
    self.frame = CGRectMake((self.superview.width - size.width) / 2, (self.superview.height - size.height) / 2, size.width, size.height);
}

@end
