//
//  WBPopMenuView.m
//  QQ_PopMenu_Demo
//
//  Created by suger on 16/3/17.
//  Copyright © 2016年 TeKSun Co. Ltd. All rights reserved.
//

#import "WBPopMenuView.h"
#import <YYKit/YYKit.h>
/*!
 *  - (IBAction)PopMenuClik:(id)sender {
 
 
 NSMutableArray *obj = [NSMutableArray array];
 
 for (NSInteger i = 0; i < [self titles].count; i++) {
 
 WBPopMenuModel * info = [WBPopMenuModel new];
 info.image = [self images][i];
 info.title = [self titles][i];
 [obj addObject:info];
 }
 
 WBPopMenuView* _popMenuView = [[WBPopMenuView alloc]initWithFrame:[UIScreen mainScreen].bounds
 menuWidth:150
 menuPoint:CGPointMake(10, -10)
 items:obj
 action:^(NSInteger index) {
 
 }];
 _popMenuView.alertType = ENWBPopMenuAlertMiddleType;
 [_popMenuView showMenu];
 }
 
 - (NSArray *) titles {
 return @[@"扫一扫",
 @"加好友",
 @"创建讨论组",
 @"发送到电脑",
 @"面对面快传",
 @"收钱"];
 }
 
 - (NSArray *) images {
 return @[@"right_menu_QR@3x",
 @"right_menu_addFri@3x",
 @"right_menu_multichat@3x",
 @"right_menu_sendFile@3x",
 @"right_menu_facetoface@3x",
 @"right_menu_payMoney@3x"];
 }
 
 */
#pragma mark -- 弹出框选择Table
#define M_TableViewCellHeight (44.f)

@interface WBPopMenuTable : UIView
@property (nonatomic ,assign)ENWBPopMenuAlertType alertType;
@property (nonatomic, strong)UIImageView* imgV;
@property (nonatomic , strong) UITableView* table;

@end

@implementation WBPopMenuTable

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        self.layer.anchorPoint = CGPointMake(0.5, 0);
        self.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        
        //小尖头
        UIImage * img =  [UIImage imageNamed:@"mall_health_Category_Triangle"];
        CGRect rect = CGRectMake(0 , 0, img.size.width, img.size.height);
        
        _imgV = [[UIImageView alloc]initWithImage:img];
        _imgV.frame =  rect;
        [self addSubview:_imgV];
        
        
        rect = CGRectMake(0, CGRectGetHeight(rect),
                          CGRectGetWidth(frame), CGRectGetHeight(frame));
        //table
        _table = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.layer.cornerRadius = 10.0f;
        
        
        _table.backgroundColor = [UIColor whiteColor];// [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        [self addSubview:_table];
        
    }
    return self;
}
- (void)setAlertType:(ENWBPopMenuAlertType)alertType {
    CGPoint anchor = CGPointZero;
    CGRect rect = CGRectZero;
    CGFloat halfW = _imgV.width *.5;
    
    switch (alertType) {
        case ENWBPopMenuAlertLeftType:
            anchor = CGPointMake(0.2, 0);
            rect = CGRectMake(CGRectGetWidth(self.frame) * .2 - halfW , 1, _imgV.width, _imgV.height);
            
            break;
        case ENWBPopMenuAlertRightType:
            
            anchor = CGPointMake(0.8, 0);
            rect = CGRectMake(CGRectGetWidth(self.frame) * .8 -  halfW, 1, _imgV.width, _imgV.height);
            
            break;
        case ENWBPopMenuAlertMiddleType:
            
            anchor = CGPointMake(0.5, 0);
            rect = CGRectMake(CGRectGetWidth(self.frame) * .5 -  halfW, 1, _imgV.width, _imgV.height);
            break;
    }
    self.layer.anchorPoint = anchor;
    _imgV.frame = rect;
    
}
@end


@interface WBPopMenuView ()

@property (nonatomic, assign) CGFloat menuX;
@property (nonatomic, assign) CGFloat menuY;
@property (nonatomic, assign) CGFloat menuWidth;
@property (nonatomic, assign) CGFloat menuHeight;


@property (nonatomic, strong) WBPopMenuTable * tableView;

@property (nonatomic, strong) WBTableViewDataSource * tableViewDataSource;
@property (nonatomic, strong) WBTableViewDelegate   * tableViewDelegate;
@property (nonatomic , strong)  UITapGestureRecognizer* tap;
@property (nonatomic , strong) UIView* touchHiddenView;

@end



#pragma mark -- 弹出框选择
@implementation WBPopMenuView


- (instancetype) init {
    if (self = [super init]) {
        self.menuY = 64.f;
        self.menuX = 0.f;
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
                     menuWidth:(CGFloat)menuWidth
                     menuPoint:(CGPoint)menuPoint
                         items:(NSArray *)items
                        action:(void(^)(NSInteger index))action {
    self.menuX = menuPoint.x;
    self.menuY = menuPoint.y;
    return [self initWithFrame:frame menuWidth:menuWidth items:items action:action];
    
}

- (instancetype) initWithFrame:(CGRect)frame
                     menuWidth:(CGFloat)menuWidth
                         items:(NSArray *)items
                        action:(void(^)(NSInteger index))action {
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.menuWidth = menuWidth;
        self.menuHeight = M_TableViewCellHeight * items.count;
        
        self.action = [action copy];
        
        self.tableViewDataSource =
        [[WBTableViewDataSource alloc]initWithItems:items
                                          cellClass:[WBTableViewCell class]
                                 configureCellBlock:^(WBTableViewCell *cell, WBPopMenuModel *model) {
                                     
                                     WBTableViewCell * tableViewCell = (WBTableViewCell *)cell;
                                     tableViewCell.textLabel.text = model.title;
                                     
                                     if (model.image) {
                                         tableViewCell.imageView.image = [UIImage imageNamed:model.image];
                                         tableViewCell.textLabel.textAlignment = NSTextAlignmentCenter;
                                     }
                                     
                                     
                                 }];
        
        
        self.tableViewDelegate = [WBTableViewDelegate new];
        
        //配置table
        _tableView = [[WBPopMenuTable alloc]initWithFrame:[self menuFrame]];
        _tableView.table.dataSource = self.tableViewDataSource;
        _tableView.table.delegate = self.tableViewDelegate;
        _tableView.table.scrollEnabled = NO;
        _tableView.table.rowHeight = M_TableViewCellHeight;
        
        
        //设置阴影
        _tableView.layer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
        _tableView.layer.shadowOffset = CGSizeMake(0, 0); //设置阴影的偏移量
        _tableView.layer.shadowRadius = 2;  //设置阴影的半径
        _tableView.layer.shadowOpacity = 0.8; //设置阴影的不透明度
        [self addSubview:_tableView];
        _tableView.userInteractionEnabled = YES;
        
        
    }
    //设置背景颜色
    //    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    //执行tableView 动画
    __weak typeof(self) wself = self;
    [UIView animateWithDuration:0.3 animations:^{
        wself.tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    
    return self;
}

- (void)setAlertType:(enum ENWBPopMenuAlertType)alertType {
    _tableView.alertType = alertType;
}

- (CGRect)menuFrame {
    CGFloat menuX = self.menuX;
    CGFloat menuY = self.menuY;
    CGFloat width = self.menuWidth;
    CGFloat heigh = self.menuHeight ;
    return (CGRect){menuX,menuY,width,heigh};
}


- (void)releaseMenu {
    
    __weak typeof(self) wself = self;
    
    wself.action = nil;
    wself.tableViewDataSource.configureCellBlock = nil;
    [_tap removeAllActionBlocks];
    
    if (_handlerPopMenuViewBlock) _handlerPopMenuViewBlock(NO);
    _handlerPopMenuViewBlock = nil;
    
    wself.tableView.table.delegate = nil;
    wself.tableView.table.dataSource = nil;
    
    [self removeFromSuperview];
    
    [_touchHiddenView removeFromSuperview];
    
    
    
    
}
- (void) hideMenu {
    
    __weak typeof(self) wself = self;
    
    wself.action = nil;
    wself.tableViewDataSource.configureCellBlock = nil;
    [_tap removeAllActionBlocks];
    
    if (_handlerPopMenuViewBlock) _handlerPopMenuViewBlock(NO);
    _handlerPopMenuViewBlock = nil;
    
    wself.tableView.table.delegate = nil;
    wself.tableView.table.dataSource = nil;
    
    [UIView animateWithDuration:0.15 animations:^{
        wself.tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        
    } completion:^(BOOL finished) {
        
        [wself.touchHiddenView removeFromSuperview];
    }];
}

- (void)showMenu {
    
    if (_handlerPopMenuViewBlock) _handlerPopMenuViewBlock(YES);
    [_touchHiddenView removeFromSuperview];
    
    CGRect rect = [UIScreen mainScreen].bounds;
    _touchHiddenView = [[UIView alloc]initWithFrame:rect];
    [_touchHiddenView addSubview:self];
    
    __weak typeof(self) wself = self;
    _tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(UITapGestureRecognizer* sender) {
        
        [wself isTapCellsByTapGesture:sender];
        [wself hideMenu];
    }];
    [_touchHiddenView addGestureRecognizer:_tap];
    [[UIApplication sharedApplication].keyWindow addSubview:_touchHiddenView];
}
#pragma mark - 计算是否点击到Cell
-(void)isTapCellsByTapGesture:(UITapGestureRecognizer *)tap {
    
    CGPoint pp = [tap locationInView:_tableView];
    //检查是否点击在 _tableView 内，
    if (pp.x < 0 || pp.x > _tableView.width ) {
        return;
    }else if (pp.y < 0 || pp.y > _tableView.height) {
        return;
    }
    //    NSLog(@"  %@", NSStringFromCGPoint(pp));
    
    //计算点击到哪一行Cell上
    NSInteger left = (NSInteger )(pp.y / M_TableViewCellHeight );
    if (_action) {
        _action(left);
    }
    
    
}

- (void)dealloc {
    [_tap removeAllActionBlocks];
    NSLog(@"~!!!!");
}

@end
