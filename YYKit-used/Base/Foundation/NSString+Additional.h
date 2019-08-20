//
//  SXNSStringAdditions.h
//  Muheda
//
//  Created by robin qyh on 2018/3/28.
//  Copyright © 2018年 于朝盼. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Additional)

// 拨打电话
- (void)call;
// 判断是否为空
- (NSString *)nullStr;

// string json 解码
- (id)maJsonDecode;

- (NSString *)limitToLength:(NSInteger)length;

//判断是否含有Emoji表情
- (BOOL)stringContainsEmoji;

- (NSAttributedString *)stringWithLineSpacing:(CGFloat)lineSpacing;

- (NSNumber *)numberValue;

- (BOOL)isMobile:(NSString *)mobileNumber;

// 判断是否是整型
- (BOOL)isPureInt;

// 判断是否为浮点型
- (BOOL)isPureFloat;

// 将时间戳毫秒值转为年月日时分秒
+ (NSString *)convertStrToTime:(NSString *)timeStr;

+ (NSString *)maIntToString:(NSInteger)value;

+ (NSString *)maFloatToString:(CGFloat)value;

//替换手机号中间4位为星号
- (NSString *)replaceMobileWithString:(NSString *)string withRange:(NSRange)range;

#pragma mark - get SandBox poth
// 获取沙盒路径
+ (NSString *)getSanBoxPath;

// 获取documents路径
+ (NSString *)getDocumentsPath;

// 获取Library路径
+ (NSString *)getLibraryPath;

// 获取caches路径
+ (NSString *)getCachesPath;

// 获取tmp路径
+ (NSString *)getTmpPath;
@end
