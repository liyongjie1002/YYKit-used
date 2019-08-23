//
//  NSObject+CurrentViewController.m
//  Muheda
//
//  Created by 于朝盼 on 2018/3/13.
//  Copyright © 2018年 于朝盼. All rights reserved.
//

#import "NSObject+CurrentVC.h"

@implementation NSObject (Category)

- (UIViewController *)getCurrentVC {

    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }

    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder  = [frontView nextResponder];

    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;

    return result;
}

- (UIViewController *)getCurrentUIVC {
    
    UIViewController *superVC = [self getCurrentVC];

    if ([superVC isKindOfClass:[UITabBarController class]]) {

        UIViewController *tabSelectVC = ((UITabBarController *) superVC).selectedViewController;

        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {

            return ((UINavigationController *) tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    } else if ([superVC isKindOfClass:[UINavigationController class]]) {

        return ((UINavigationController *) superVC).viewControllers.lastObject;
    }
    return superVC;
}

//防止crash
- (void)setNilValueForKey:(NSString *)key {
}

//防止crash
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}
@end
