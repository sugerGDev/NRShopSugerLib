//
//  ViewController.m
//  NRShopSugerLib
//
//  Created by mihaia on 16/8/16.
//  Copyright © 2016年 NutritionRite Co.,Ltd. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "MBTIMgrTextField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MBTIMgrTextField* txtField  = [MBTIMgrTextField textField];
    [self.view addSubview:txtField];
    
    txtField.placeholder = @"请输入你想输入的数据";
    txtField.isNeedPhoneNumSgmentation = YES;
    [txtField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@20);
        make.top.equalTo(self.view).offset(70);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
