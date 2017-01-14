//
//  UIScrollView+CustomAdd.m
//  NRCGlobalShop
//
//  Created by suger on 16/9/28.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import "UIScrollView+CustomAdd.h"

@implementation UIScrollView (CustomMJRefresh)
- (void)addHeaderRefreshCompBlock:(MJRefreshComponentRefreshingBlock)block {
    
    [self headerRefreshCompInvalid];
    //    Preloader_1_01
    NSLog(@"NOTE：不要在ViewWilDidLoad， ViewDidLoad ，init 中使用 header 或者 footer 进行refresh～ ");
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        // 进入刷新状态后会自动调用这个block
        if (block) {
            block();
        }
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
    
    
    NSArray *_refreshImages = @[[UIImage imageNamed:@"refresh.bundle/Preloader_1_01"],
                                [UIImage imageNamed: @"refresh.bundle/Preloader_1_02"],
                                [UIImage imageNamed:@"refresh.bundle/Preloader_1_03"],
                                [UIImage imageNamed: @"refresh.bundle/Preloader_1_04"],
                                [UIImage imageNamed:@"refresh.bundle/Preloader_1_05"],
                                [UIImage imageNamed:@"refresh.bundle/Preloader_1_06]"],
                                [UIImage imageNamed:@"refresh.bundle/Preloader_1_07"],
                                [UIImage imageNamed: @"refresh.bundle/Preloader_1_08"]];
    
    [header setImages:_refreshImages forState:MJRefreshStateRefreshing];
    [header setImages:@[_refreshImages.firstObject]  forState:MJRefreshStateIdle];
    
    
    
    //        dispatch_async(dispatch_get_main_queue(), ^{
    
    self.mj_header = header;
    //        });
    //    });
}

- (void)headerRefreshing {
    [self.mj_header beginRefreshing];
}
- (void)headerRefreshCompInvalid {
    [self endRefresh];
    self.mj_header = nil;
}

- (void)addFooterRefreshCompBlock:(MJRefreshComponentRefreshingBlock)block {
    
    
    [self footerRefreshCompInvalid];
    
    NSLog(@"NOTE：不要在ViewWilDidLoad， ViewDidLoad ，init 中使用 header 或者 footer 进行refresh～ ");
    MJRefreshAutoGifFooter* footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        if (block) {
            block();
        }
    }];
    
    //    footer.lastUpdatedTimeLabel.hidden = YES;
    //    footer.stateLabel.hidden = YES;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        
        NSArray *_refreshImages = @[[UIImage imageNamed:@"refresh.bundle/Preloader_1_01"],
                                    [UIImage imageNamed: @"refresh.bundle/Preloader_1_02"],
                                    [UIImage imageNamed:@"refresh.bundle/Preloader_1_03"],
                                    [UIImage imageNamed: @"refresh.bundle/Preloader_1_04"],
                                    [UIImage imageNamed:@"refresh.bundle/Preloader_1_05"],
                                    [UIImage imageNamed:@"refresh.bundle/Preloader_1_06]"],
                                    [UIImage imageNamed:@"refresh.bundle/Preloader_1_07"],
                                    [UIImage imageNamed: @"refresh.bundle/Preloader_1_08"]];
        
        [footer setImages:_refreshImages forState:MJRefreshStateRefreshing];
        [footer setImages:@[_refreshImages.firstObject]  forState:MJRefreshStateIdle];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.mj_footer = footer;
        });
    });
    
}

- (void)footerRefreshing {
    [self.mj_footer beginRefreshing];
}

- (void)footerRefreshCompInvalid {
    [self endRefresh];
    self.mj_footer = nil;
}

- (void)endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)endRefreshScroll:(BOOL)scroll {
    if (scroll) {
        //尾部刷新完成后，往上滚动一部分
        if (self.mj_footer.isRefreshing) {
            [self scrollRectToVisible:CGRectMake(0, self.contentOffset.y + 50 /*self.height / 2*/, self.width, self.height) animated:YES];
        }
    }
    [self endRefresh];
}
@end


@implementation UIScrollView (CustomData)
- (void)dealloc {
    self.dataArray = nil;
}
#pragma mark - Data
- (NSMutableArray *)dataArray {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    if (NO == [dataArray isKindOfClass:[NSMutableArray class]]) {
        NSLog(@"％@ failed set dataArray !!!");
        return;
    }
    
    objc_setAssociatedObject(self, @selector(dataArray),
                             dataArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSUInteger)pageIndex {
    return [objc_getAssociatedObject(self, _cmd) unsignedIntValue];
}

- (void)setPageIndex:(NSUInteger)pageIndex {
    //默认从1开始
    if (pageIndex < 1) {
        pageIndex = 1;
    }
    objc_setAssociatedObject(self, @selector(pageIndex),
                             @(pageIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NRCRefreshType)refreshType {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setRefreshType:(NRCRefreshType)refreshType {
    
    objc_setAssociatedObject(self, @selector(refreshType),
                             @(refreshType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Public

- (void)prepareForRefreshType:(NRCRefreshType)refreshType {
    //默认从1开始
    self.pageIndex = (refreshType == NRCRefreshTypeHeader) ? 1 : (self.pageIndex += 1) ;
    self.refreshType = refreshType;
}
- (void)finishSuccess:(BOOL)isSuc WithArray:(NSArray *)arr
           AtTotalNum:(NSInteger)total
          PrcessBlock:(HanderProcessBlock)pBlock ComplBlock:(HanderComplBlock)cBlock {
    
    
    [self endRefresh];
    
    //请求数据不成功，并且是footer 刷新
    if (isSuc == NO && self.refreshType == NRCRefreshTypeFooter) {
        self.pageIndex -= 1;
        return ;
    }
    //头部刷新
    if (self.refreshType == NRCRefreshTypeHeader) {
        
        //处理TableView 中的数据
        if (pBlock) {
            self.dataArray = pBlock(arr);
        }else{
            //默认处理中方法
            self.dataArray = [arr mutableCopy];
        }
        
        BOOL isHaveData = self.dataArray.count;
        //越界保护
        {
            if (self.dataArray.count >= total) {
                isHaveData = NO;
            }
        }
        
        if (cBlock) {
            cBlock(isHaveData);
        }
        
    }else{
        //尾部刷新 有数据就进行处理，不判断total
        if (arr.count /*&&
                       self.dataArray.count <= total*/) {
                           
                           //处理TableView 中的数据
                           if (pBlock) {
                               [self.dataArray addObjectsFromArray:pBlock(arr) ];
                           }else{
                               //默认处理中方法
                               [self.dataArray addObjectsFromArray:arr];
                           }
                           
                           //越界保护
                           BOOL isHaveData = YES;
                           {
                               if (self.dataArray.count >= total) {
                                   isHaveData = NO;
                               }
                           }
                           
                           if(cBlock) {
                               cBlock(isHaveData);
                           }
                       }else{
                           
                           if (cBlock) {
                               cBlock(NO);
                           }
                           
                       }
    }
    
    cBlock = nil;
    
}

- (void)finishSuccess:(BOOL)isSuc WithArray:(NSArray *)arr
           AtTotalNum:(NSInteger)total ComplBlock:(HanderComplBlock)cBlock{
    
    [self finishSuccess:isSuc WithArray:arr
             AtTotalNum:total PrcessBlock:nil ComplBlock:cBlock];
    
}
@end
