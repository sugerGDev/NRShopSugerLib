//
//  WBTableViewDataSource.m
//
//  Created by suger on 16/3/9.
//  Copyright © 2016年 TeKSun Co. Ltd. All rights reserved.
//

#import "WBTableViewDataSource.h"



@interface WBTableViewDataSource ()
@property (nonatomic, strong) Class Cellclass;
@property (nonatomic, strong) NSArray * modelArray;

@end
@implementation WBTableViewDataSource

- (instancetype) initWithItems:(NSArray *)anItems
                     cellClass:(Class)cellClass
            configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock {
    
    if (self = [super init]) {
        
        self.modelArray = anItems;
        self.configureCellBlock = [aConfigureCellBlock copy];
        self.Cellclass = cellClass;
    }
    return self;
}



- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WBTableViewCell * cell = [[self.Cellclass class]cellAllocWithTableView:tableView];
   
    //配置Cell
    if(_configureCellBlock)_configureCellBlock(cell,self.modelArray[indexPath.row]);
    return cell;
}
@end


@implementation WBPopMenuModel

- (instancetype)initWithI:(NSString *)img t:(NSString *)title {
    if (self = [super init]) {
        _image = img;
        _title = title;
    }
    return self;
}
@end



@implementation WBTableViewCell


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:13];
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    //    tableCell 补全划线
    CGFloat lineHeight = rect.size.height ;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.f);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextMoveToPoint(context, 0, lineHeight);
    CGContextAddLineToPoint(context, rect.size.width , lineHeight);
    CGContextStrokePath(context);
    
}



+ (instancetype) cellAllocWithTableView:(UITableView *)tableView {
    
    WBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[[self class] alloc] initWithStyle:0 reuseIdentifier:NSStringFromClass([self class])];
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

@end