//
//  SXNSStringAdditions.m
//  Muheda
//
//  Created by robin qyh on 2018/3/28.
//  Copyright © 2018年 于朝盼. All rights reserved.
//

#import "NSString+Additional.h"
#import <commoncrypto/CommonDigest.h>
#import "NSDate+YYAdd.h"

@implementation NSString (Additional)

- (void)call {
    NSString *telStr = [NSString stringWithFormat:@"tel:%@", self];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]
                                           options:nil
                                 completionHandler:^(BOOL success){
                                 }];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
    }
}

- (NSString *)nullStr {
    return self == nil ? @"" : self;
}

- (id)maJsonDecode {
    if (![self isKindOfClass:[NSString class]])
        return nil;
    NSData *data   = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
}

- (NSString *)limitToLength:(NSInteger)length {
    if (self.length <= length) {
        return self;
    }

    NSMutableString *newStr = [NSMutableString string];
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              if (newStr.length + substring.length <= length) {
                                  [newStr appendString:substring];
                              }
                          }];
    return newStr;
}

- (BOOL)stringContainsEmoji {
    __block BOOL returnValue = NO;

    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc     = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c ||
                                             hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }
                              }
                          }];

    return returnValue;
}

- (NSAttributedString *)stringWithLineSpacing:(CGFloat)lineSpacing {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSMutableParagraphStyle *paragraphStyle     = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing]; //调整行间距
    [paragraphStyle setParagraphSpacing:0];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self length])];
    return attributedString;
}

- (NSNumber *)numberValue {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    return [formatter numberFromString:self];
}

- (BOOL)isMobile:(NSString *)mobileNumber {
    NSString *MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";

    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";

    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";

    NSString *CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";

    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct     = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];

    if (([regextestmobile evaluateWithObject:mobileNumber] || [regextestcm evaluateWithObject:mobileNumber] ||
         [regextestct evaluateWithObject:mobileNumber] || [regextestcu evaluateWithObject:mobileNumber])) {
        return YES;
    }
    return NO;
}

//判断是否为整型浮点形：
- (BOOL)isPureInt {
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
- (BOOL)isPureFloat {
    NSScanner *scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

// 将毫秒值转为年月日时分秒
+ (NSString *)convertStrToTime:(NSString *)timeStr {

    long long time       = [timeStr longLongValue];
    NSDate *d            = [[NSDate alloc] initWithTimeIntervalSince1970:time / 1000.0];
    NSString *timeString = [d stringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    return timeString;
}

+ (NSString *)maIntToString:(NSInteger)value {
    return [NSString stringWithFormat:@"%ld", (long) value];
}

+ (NSString *)maFloatToString:(CGFloat)value {
    return [NSString stringWithFormat:@"%f", value];
}

//替换手机号中间4位为星号
- (NSString *)replaceMobileWithString:(NSString *)string withRange:(NSRange)range {

    NSString *originString = self;

    if (originString.length < 4) {
        return originString;
    } else if (originString.length < 8) {
        NSRange tmpRange    = NSMakeRange(3, originString.length - 3);
        NSString *str       = [string substringToIndex:tmpRange.length];
        NSString *tmpString = [originString stringByReplacingCharactersInRange:tmpRange withString:str];
        return tmpString;
    } else {
        NSString *tmpString = [originString stringByReplacingCharactersInRange:range withString:string];
        return tmpString;
    }
}

+ (NSString *)getSanBoxPath {
    NSString *sanboxPathStr = NSHomeDirectory();
    return sanboxPathStr;
}

+ (NSString *)getDocumentsPath {
    NSArray *documentPOaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucmentPath  = [documentPOaths objectAtIndex:0];
    return doucmentPath;
}

+ (NSString *)getLibraryPath {
    NSArray *pathArray       = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryStrPath = [pathArray objectAtIndex:0];
    return libraryStrPath;
}

+ (NSString *)getCachesPath {
    NSArray *cachesPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [cachesPaths objectAtIndex:0];
    return cachesPath;
}

+ (NSString *)getTmpPath {
    NSString *tmpDir = NSTemporaryDirectory();
    return tmpDir;
}

// url 参数
- (NSMutableDictionary *)parseURLParameters {

    // 查找参数
    NSRange range = [self rangeOfString:@"?"];
    if (range.location == NSNotFound) {
        return nil;
    }

    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    // 截取参数
    NSString *parametersString = [self substringFromIndex:range.location + 1];

    // 判断参数是单个参数还是多个参数
    if ([parametersString containsString:@"&"]) {

        // 多个参数，分割参数
        NSArray *urlComponents = [parametersString componentsSeparatedByString:@"&"];

        for (NSString *keyValuePair in urlComponents) {
            // 生成Key/Value
            NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
            NSString *key           = [pairComponents.firstObject stringByRemovingPercentEncoding];
            NSString *value         = [pairComponents.lastObject stringByRemovingPercentEncoding];

            // Key不能为nil
            if (key == nil || value == nil) {
                continue;
            }

            id existValue = [params valueForKey:key];

            if (existValue != nil) {

                // 已存在的值，生成数组
                if ([existValue isKindOfClass:[NSArray class]]) {
                    // 已存在的值生成数组
                    NSMutableArray *items = [NSMutableArray arrayWithArray:existValue];
                    [items addObject:value];

                    [params setValue:items forKey:key];
                } else {

                    // 非数组
                    [params setValue:@[ existValue, value ] forKey:key];
                }

            } else {

                // 设置值
                [params setValue:value forKey:key];
            }
        }
    } else {
        // 单个参数

        // 生成Key/Value
        NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];

        // 只有一个参数，没有值
        if (pairComponents.count == 1) {
            return nil;
        }

        // 分隔值
        NSString *key   = [pairComponents.firstObject stringByRemovingPercentEncoding];
        NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];

        // Key不能为nil
        if (key == nil || value == nil) {
            return nil;
        }

        // 设置值
        [params setValue:value forKey:key];
    }

    return params;
}

- (NSString *)deleteParameterForKey:(NSString *)key {
    NSString *finalString = [NSString string];

    if ([self containsString:key]) {
        NSMutableString *mutStr = [NSMutableString stringWithString:self];
        NSArray *strArray       = [mutStr componentsSeparatedByString:key];

        NSMutableString *firstStr = [strArray objectAtIndex:0];
        NSMutableString *lastStr  = [strArray lastObject];

        NSRange characterRange = [lastStr rangeOfString:@"&"];

        if (characterRange.location != NSNotFound) {
            NSArray *lastArray       = [lastStr componentsSeparatedByString:@"&"];
            NSMutableArray *mutArray = [NSMutableArray arrayWithArray:lastArray];
            [mutArray removeObjectAtIndex:0];

            NSString *modifiedStr = [mutArray componentsJoinedByString:@"&"];
            finalString           = [[strArray objectAtIndex:0] stringByAppendingString:modifiedStr];
        } else {
            //以‘?‘、‘&‘结尾
            finalString = [firstStr substringToIndex:[firstStr length] - 1];
        }
    } else {
        finalString = self;
    }

    return finalString;
}

- (NSString *)addParameters:(NSDictionary *)parameters {
    NSMutableArray *parts = [NSMutableArray array];

    for (NSString *key in [parameters allKeys]) {
        NSString *part = [NSString stringWithFormat:@"%@=%@", key, [parameters valueForKey:key]];
        [parts addObject:part];
    }

    NSString *parametersString = [parts componentsJoinedByString:@"&"];

    NSString *addSuffixString = @"";
    if ([self hasParameter]) { // 原链接已经存在参数, 则用"&"直接拼接参数;
        addSuffixString = [NSString stringWithFormat:@"%@%@", @"&", parametersString];
    } else { // 原链接不存在参数, 则先添加"?", 再拼接参数;
        addSuffixString = [NSString stringWithFormat:@"%@%@", @"?", parametersString];
    }
    
    return [self stringByAppendingString:addSuffixString];
}

#pragma mark - Private Methods

- (BOOL)hasParameter {
    return [[self parseURLParameters] count] > 0;
}

@end
