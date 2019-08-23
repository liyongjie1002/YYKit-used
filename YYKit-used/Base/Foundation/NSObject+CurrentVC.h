//
//  NSObject+CurrentViewController.h
//  Muheda
//
//  Created by 于朝盼 on 2018/3/13.
//  Copyright © 2018年 于朝盼. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSObject (Category)

// 当前window的根视图控制器
- (UIViewController *)getCurrentVC;

// 根视图控制器最顶层VC
- (UIViewController *)getCurrentUIVC;

@end
