//
//  WBTableViewDelegate.m
//
//  Created by suger on 16/3/9.
//  Copyright © 2016年 TeKSun Co. Ltd. All rights reserved.
//

#import "WBTableViewDelegate.h"


@implementation WBTableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
