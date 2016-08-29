//
//  ViewController.m
//  NRShopSugerLib
//
//  Created by mihaia on 16/8/16.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "NRShopSugerLib.h"

@interface ViewController (){
    
    __weak  MBTIMgrTextField *_txtField ;
    __weak ZBannerView *_bannerView;
    
}
@end

@implementation ViewController
- (void)dealloc {
    [self.view removeAllButtonTapActions];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //输入框
    _txtField = [MBTIMgrTextField initObjectWithBlock:^(MBTIMgrTextField *txtField) {
        
        [self.view addSubview:txtField];
        txtField.placeholder = @"请输入你想输入的数据";
        //        txtField.isNeedPhoneNumSgmentation = YES;
        
        [txtField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(30);
            make.right.equalTo(self.view).offset(-30);
            make.height.mas_equalTo(@20);
            make.top.equalTo(self.view).offset(70);
        }];
    }];
    
    //滚动视图
    __weak typeof(_txtField) weakTxtField = _txtField;
   _bannerView = [ZBannerView initObjectWithBlock:^(ZBannerView *banner) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        [self.view addSubview:banner];
        // 网络数据源
        NSArray * imagesURL = @[  @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1833469/porter.jpg",
                                  @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1521183/farmers.jpg",
                                  @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1391053/tents.jpg"];
        banner.imageUrls = imagesURL;
        
        [banner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo( @150);
            make.top.equalTo(weakTxtField.mas_bottom).offset(30);
        }];
    }];
    
    
    //Button
    __weak typeof(_bannerView) weakBannerView = _bannerView;
    [UIButton initObjectWithBlock:^(UIButton *btn) {
        [self.view addSubview:btn];
        
        btn.backgroundColor = [UIColor redColor];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.width.height.mas_equalTo(@200);
            make.top.equalTo(weakBannerView.mas_bottom).offset(30);
        }];
        
        //Tap Action
        [btn addTapActionBlock:^(UIButton *tapSender) {
            [[UIApplication sharedApplication].keyWindow endEditing:YES];
        }];
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
