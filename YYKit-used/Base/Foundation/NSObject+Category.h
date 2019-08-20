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

- (UIViewController *)getCurrentVC;

- (UIViewController *)getCurrentUIVC;

@end
