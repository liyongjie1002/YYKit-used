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

// 判断是否为空，如果为空，返回@""
- (NSString *)nullStr;

// string json 解码
- (id)maJsonDecode;

// 字符串限制长度
- (NSString *)limitToLength:(NSInteger)length;

//判断是否含有Emoji表情
- (BOOL)stringContainsEmoji;

// 调整行间距
- (NSAttributedString *)stringWithLineSpacing:(CGFloat)lineSpacing;

// 转为NSNumber
- (NSNumber *)numberValue;

// 是否是手机号
- (BOOL)isMobile:(NSString *)mobileNumber;

// 判断是否是整型
- (BOOL)isPureInt;

// 判断是否为浮点型
- (BOOL)isPureFloat;

// 将时间戳毫秒值转为年月日时分秒
+ (NSString *)convertStrToTime:(NSString *)timeStr;

// 整型转换为字符串
+ (NSString *)maIntToString:(NSInteger)value;

// 浮点型转换为字符串
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

#pragma mark 操作url字符串
// 将Url中的所有参数组装为字典
- (NSMutableDictionary *)parseURLParameters;

// 删除某个键值对
- (NSString *)deleteParameterForKey:(NSString *)key;

// 增加某个键值对
- (NSString *)addParameters:(NSDictionary *)parameters;
@end
