//
//  UIScrollView+CustomAdd.h
//  NRCGlobalShop
//
//  Created by suger on 16/9/28.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MJRefresh.h>
#import <YYKit.h>

//刷新类别
typedef NS_ENUM(NSInteger, NRCRefreshType) {
    NRCRefreshTypeHeader = 0 , //头部
    NRCRefreshTypeFooter = 1,  //尾部
};

/*!
 *  @brief 刷新分类
 */

@interface UIScrollView (CustomMJRefresh)
/*!
 *  @brief 头部刷新控件添加
 *
 *  @param block <#block description#>
 */
- (void)addHeaderRefreshCompBlock:(MJRefreshComponentRefreshingBlock)block;
/*!
 *  @brief 头部开始刷新
 */
- (void)headerRefreshing;
/*!
 *  @brief 头部刷新无效
 */
- (void)headerRefreshCompInvalid;
/*!
 *  @brief 尾部控件添加
 *
 *  @param block <#block description#>
 */
- (void)addFooterRefreshCompBlock:(MJRefreshComponentRefreshingBlock)block;
/*!
 *  @brief 尾部刷新
 */
- (void)footerRefreshing;
/*!
 *  @brief  尾部刷新无效
 */
- (void)footerRefreshCompInvalid;
/*!
 *  @brief 结束刷新
 */
- (void)endRefresh;

- (void)endRefreshScroll:(BOOL)scroll;

@end

/*!
 *  @brief 数据部分
 */
typedef void (^HanderComplBlock)(BOOL ownTheData);
typedef NSMutableArray* (^HanderProcessBlock)(NSArray* dataArray);

@interface UIScrollView (CustomData)
//保存当前的刷新数据
@property (nonatomic , strong) NSMutableArray* dataArray;   //当前的数据源

@property (nonatomic , assign) NSUInteger pageIndex;    //当前分页页码 默认从 1 开始
@property (nonatomic , assign) NRCRefreshType refreshType; //当前的刷新类型 (缺省)

/*!
 *  @brief 准备开始刷新的时候
 *
 *  @param refreshType 刷新类型
 */
- (void)prepareForRefreshType:(NRCRefreshType) refreshType;
/*!
 *  @brief 完成刷新数据处理
 *
 *  @param refreshType 刷新类型
 */
- (void)finishSuccess:(BOOL)isSuc WithArray:(NSArray *)arr
           AtTotalNum:(NSInteger)total ComplBlock:(HanderComplBlock)cBlock;

/*!
 *  @brief 处理里请求完毕后数据处理
 *
 *  @param isSuc  <#isSuc description#>
 *  @param arr    <#arr description#>
 *  @param total  <#total description#>
 *  @param cBlock <#cBlock description#>
 */
- (void)finishSuccess:(BOOL)isSuc WithArray:(NSArray *)arr
           AtTotalNum:(NSInteger)total
          PrcessBlock:(HanderProcessBlock)pBlock ComplBlock:(HanderComplBlock)cBlock;
@end



