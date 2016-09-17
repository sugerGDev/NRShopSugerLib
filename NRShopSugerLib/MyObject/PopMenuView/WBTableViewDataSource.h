//
//  WBTableViewDataSource.h
//
//  Created by suger on 16/3/9.
//  Copyright © 2016年 TeKSun Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * 由model 设置cell 的回调
 */
@class WBPopMenuModel,WBTableViewCell;
typedef void(^TableViewCellConfigureBlock) (WBTableViewCell * cell,WBPopMenuModel * model);


/*!
 *  弹出框实体类
 */
#pragma mark -- Module
@interface WBPopMenuModel : NSObject

@property (nonatomic ,copy) NSString * image;
@property (nonatomic ,copy) NSString * title;
- (instancetype)initWithI:(NSString *)img t:(NSString *)title;
@end

/*!
 *  弹出框Table Cell
 */
#pragma mark -- Cell
@interface WBTableViewCell : UITableViewCell

/**
 *  使用 alloc 创建cell
 *
 *  @param tableView 表格控件
 *
 *  @return 创建的 cell
 *
 *  内已做复用处理
 *  如果有特殊要求 可以重写此方法
 */
+ (instancetype)cellAllocWithTableView:(UITableView *)tableView;


@end




/**
 * 数据源管理类的封装
 */
#pragma mark -- DataSource
@interface WBTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
/**
 *  创建数据源管理
 *
 *  @param anItems             数据源
 *  @param cellClass           cell 类
 *  @param aConfigureCellBlock 设置cell的回调
 */
- (instancetype) initWithItems:(NSArray *)anItems
                     cellClass:(Class)cellClass
            configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

@end
