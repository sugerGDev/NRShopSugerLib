//
//  NSString+Valid.h
//  Kurrent
//
//  Created by hcl on 15/9/14.
//  Copyright (c) 2015年 Kurrent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (CustomValid)


///合法身份证
- (BOOL)isValidPersonIDCardNumber;

///银行卡校验规则(Luhn算法)
- (BOOL)isValidBankCardNumber;

/// 是否是是航班号  车次号
- (BOOL)isFlightOrTrainNumber;

///是否全部是数字
- (BOOL)isNumber;
/// 是否全部数字和字母组成
- (BOOL)isAlphanumeric;

///中文 字母等
- (BOOL)isChineseAlphabet;
///手机号码
- (BOOL)isValidMobileNumber;
///邮箱地址
- (BOOL)isValidEmailAddress;
///网页html
- (BOOL)isValidHtmlURL;
///合法密码
- (BOOL)isValidPassword;
///合法IP地址
- (BOOL)isValildIPAddress;
///合法IP端口
- (BOOL)isValidIPPort;
/*!
 *  是否不是空字符串
 */
- (BOOL)isStringEmpty;

/*!
 *  @brief 11 位转成 13位带分割空格字符串
 */
+(NSString *)stringFomatPhone:(NSString *)phone;
/*!
 *  @brief 13 位转成 11位手机号
 */
+(NSString *)phoneFomatString:(NSString *)string;

/*!
 *  @brief 11 位转成 11位带掩码 字符串
 */
+(NSString *)stringFomatMaskPhone:(NSString *)string;

// 正常号转银行卡号 － 增加4位间的空格
-(NSString *)normalNumToBankNum;
// 正常号转手机号 － 增加4位间的空格
-(NSString *)normalNumToPhoneNum;
// 分割号转正常号 － 去除4位间的空格
-(NSString *)segmentationToNormalNum;

#pragma mark -textField
///合法金额输入...用于textField  delegate
- (BOOL)isValidMoneyWithRange:(NSRange)range replacementString:(NSString *)string;
///判断text 最大长度 maxLength = 0 return YES
- (BOOL)isValidMaxLength:(NSUInteger)maxLength WithRange:(NSRange)range replacementString:(NSString *)string;

@end
/*!
 *  @brief 对图片进行剪裁URI 处理
 */
@interface NSString (QiNiu)
//根据手机需要的图片尺寸对图片进行剪裁
- (NSString *)imgURIByOrginalSize:(CGSize)oSize ;
//根据手机需要的图片宽度对图片进行缩放
- (NSString *)imgURIByFixedWidth:(CGFloat)width ;
//根据手机需要的图片高度对图片进行缩放
- (NSString *)imgURIByFixedHight:(CGFloat)height;
@end
