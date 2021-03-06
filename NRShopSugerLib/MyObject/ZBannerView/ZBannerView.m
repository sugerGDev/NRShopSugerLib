//
//  ZBannerView.m
//  ZBannerViewDemo
//
//  Created by 张彦东 on 15/12/1.
//  Copyright © 2015年 yd. All rights reserved.
//

#import "ZBannerView.h"
#import <YYKit/YYKit.h>
#import <Masonry/Masonry.h>

// 图片滚动时间间隔
#define kImageScrollTimeInterval 10.0


typedef NS_ENUM(NSUInteger, ZBannerScrollType) {
    ZBannerScrollTypeStatic, // 非滑动状态
    ZBannerScrollTypeLeft,
    ZBannerScrollTypeRight
};

@interface ZBannerView () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl * pageControl;

@property (nonatomic, weak) UIScrollView * scrollView;


// 当前显示图片的Index
@property (nonatomic, assign) NSInteger currentImageIndex;

// 滚动时显示的Image
@property (nonatomic, weak) YYAnimatedImageView * reuseImageView;
// 静止时候显示的Image
@property (nonatomic, weak) YYAnimatedImageView * displayImageView;
// 滚动状态
@property (nonatomic, assign) ZBannerScrollType scrollType;

@end

@implementation ZBannerView

#pragma mark - 生命周期函数
- (void)removeFromSuperview {
    [super removeFromSuperview];
}
- (void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self.displayImageView cancelCurrentImageRequest];
    [self.reuseImageView cancelCurrentImageRequest];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    self.scrollView.delegate = nil;
    
}
- (instancetype)init {
    if (self = [super init]) {
        [self setupViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        [self setupViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, 0);
    
    CGFloat vWidth = self.scrollView.frame.size.width;
    CGFloat vHeight = self.scrollView.frame.size.height;
    self.displayImageView.frame = CGRectMake(vWidth, 0, vWidth, vHeight);
    self.reuseImageView.frame = CGRectMake(0, 0, vWidth, vHeight);
    [self loadDisplayImage];
}

// 一些View的初始化设置
- (void)setupViews {
    
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
    }];
    
    
    UIPageControl * pageControl = [[UIPageControl alloc] init];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(@20);
        make.bottom.equalTo(self).offset(-10);
    }];
    
    
    YYAnimatedImageView * displayImageView = [YYAnimatedImageView new];
    [self.scrollView addSubview:displayImageView];
    self.displayImageView = displayImageView;
    displayImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)];
    [displayImageView addGestureRecognizer:tgr];
    displayImageView.layer.masksToBounds = YES;
    
    YYAnimatedImageView * reuseImageView = [YYAnimatedImageView new];
    [self.scrollView addSubview:reuseImageView];
    self.reuseImageView = reuseImageView;
    reuseImageView.layer.masksToBounds = YES;
    
    
    displayImageView.backgroundColor = [UIColor colorWithWhite:0.667 alpha:0.500];
    reuseImageView.backgroundColor = [UIColor colorWithWhite:0.667 alpha:0.500];
    
    displayImageView.contentMode = UIViewContentModeScaleAspectFill;
    reuseImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.isAutoScrollView = YES; //默认开启自动滚动
}

// 判断View是否在屏幕中
- (BOOL)isInScreen:(CGRect)frame {
    return (CGRectGetMaxX(frame) > self.scrollView.contentOffset.x) &&
    (CGRectGetMinX(frame) < self.scrollView.contentOffset.x + self.scrollView.bounds.size.width);
}


#pragma mark - Setter 设置数据源
- (void)setImageUrls:(NSArray *)imageUrls {
    
    _imageUrls = imageUrls;
    self.pageControl.numberOfPages = imageUrls.count;

    //只有一张的时候停止滚动，并且防止触摸、
    BOOL isScroll = !(imageUrls.count == 1);
    
    [self.scrollView setScrollEnabled:isScroll];
    self.isAutoScrollView = isScroll;
    if(!isScroll)[_pageControl removeFromSuperview];
    
    
    [self loadDisplayImage];
}


#pragma mark - 加载图片
- (void)loadDisplayImage {
    
    NSString* urlStr = self.imageUrls[self.currentImageIndex ];
    NSURL* url = [NSURL URLWithString:urlStr];
    
    BOOL fileExist = ([urlStr rangeOfString:@"http"].location != NSNotFound);
    if (fileExist == NO) {
        
        self.displayImageView.image = [UIImage imageNamed:urlStr];
        
    }else{
        
        UIImage* img = [UIImage imageNamed:@"placeholder_banner"];
        [self.displayImageView setImageWithURL:url  placeholder:img];
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0)];
    self.pageControl.currentPage = self.currentImageIndex;
    
    if (
        [self.zbDelegate respondsToSelector:@selector(bannerView:imageDidDisplayWithIndex:)]) {
        [self.zbDelegate bannerView:self imageDidDisplayWithIndex:self.currentImageIndex];
    }
}

- (void)loadReuseImage {
    CGRect frame = self.reuseImageView.frame;
    NSInteger reuseIndex = self.currentImageIndex;
    if (self.scrollType == ZBannerScrollTypeLeft) {
        frame.origin.x = 0;
        reuseIndex = [self formatIndexWithIndex:reuseIndex - 1];
    } else {
        frame.origin.x = self.scrollView.frame.size.width * 2;
        reuseIndex = [self formatIndexWithIndex:reuseIndex + 1];
    }
    
    
    NSString* urlStr = self.imageUrls[reuseIndex ];
    [self.reuseImageView setImageURL:[NSURL URLWithString:urlStr]];
    self.reuseImageView.frame = frame;
}

- (NSInteger)formatIndexWithIndex:(NSInteger)idx {
    NSInteger resultIdx = idx;
    if (resultIdx < 0) {
        resultIdx = self.imageUrls.count - 1;
    } else if (resultIdx == self.imageUrls.count) {
        resultIdx = 0;
    }
    return resultIdx;
}

// 更新当前image的index
- (void)updateCurrentIndex {
    if (self.scrollType == ZBannerScrollTypeLeft) {
        self.currentImageIndex = [self formatIndexWithIndex:self.currentImageIndex - 1];
    } else {
        self.currentImageIndex = [self formatIndexWithIndex:self.currentImageIndex + 1];
    }
}

#pragma mark - 自动滚动计时器
- (void)setIsAutoScrollView:(BOOL)isAutoScrollView {
    _isAutoScrollView = isAutoScrollView;
    
    if (_isAutoScrollView == NO) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }else {
        [self startTimer];
    }
}
- (void)startTimer {
    [self performSelector:@selector(scrollImage) afterDelay:kImageScrollTimeInterval];
}



- (void)scrollImage {
    // 关闭自动滚动
    if (_isAutoScrollView == NO) {
        return;
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    CGPoint offset = CGPointMake(self.scrollView.frame.size.width * 2, 0);
    [self.scrollView setContentOffset:offset animated:YES];
    
    [self performSelector:@selector(scrollImage) afterDelay:kImageScrollTimeInterval];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat cosX = scrollView.contentOffset.x;
    // 当显示页面消失在屏幕时立刻更新Display Image
    if (![self isInScreen:self.displayImageView.frame]) {
        // 更新Current Index
        [self updateCurrentIndex];
        // 还原滚动方向
        self.scrollType = ZBannerScrollTypeStatic;
        // 更新Display Image
        [self loadDisplayImage];
        
        // 判断滚动方向
    } else if (cosX > self.frame.size.width) {
        // 右
        if (self.scrollType != ZBannerScrollTypeRight) {
            self.scrollType = ZBannerScrollTypeRight;
            [self loadReuseImage];
        }
    } else {
        // 左
        if (self.scrollType != ZBannerScrollTypeLeft) {
            self.scrollType = ZBannerScrollTypeLeft;
            [self loadReuseImage];
        }
    }
}

#pragma mark - 点击图片回调代理
- (void)imageClick {
    if ([self.zbDelegate respondsToSelector:@selector(bannerView:imageDidClickWithIndex:)]) {
        [self.zbDelegate bannerView:self imageDidClickWithIndex:self.currentImageIndex];
    }
}

@end
