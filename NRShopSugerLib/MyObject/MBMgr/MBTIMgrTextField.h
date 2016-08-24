//
//  MBTIMgrTextField.h
//  MBTravel
//
//  Created by suger on 15/12/12.
//  Copyright © 2015年 TeKSun Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * 重载 UITextField 控件， 自定义一些属性
 */
@interface MBTIMgrTextField : UITextField<UITextFieldDelegate>
/*!
 *  @brief 单利创建TextField
 *
 *  @return 创建的TextField 对象
 *
 *  @since 1.0
 */
+(instancetype)textField;
/*!
 *  限制字符字数，若默认不设置，限制20个字符
 */
@property (nonatomic , assign, readwrite) NSNumber* limitNumber;
/*!
 *  @brief 是否需要手机号的分割功能
 *
 *  @since <#1.0#>
 */
@property (nonatomic , assign) BOOL isNeedPhoneNumSgmentation;

/*!
 *  @brief 是否需要银行卡号的分割功能
 *
 *  @since <#1.0#>
 */
@property (nonatomic , assign) BOOL isNeedBankNumSgmentation;
//-------------------设置指定边距大小-------------------
- (void)setEdgeOffsetToLeft:(CGFloat)lOffset;
- (void)setEdgeOffsetToRight:(CGFloat)rOffset;
//-------------------设置指定边距大小-------------------

- (BOOL)isValidName;
- (BOOL)isValidPhone;
- (BOOL)isEmpty;
@end
