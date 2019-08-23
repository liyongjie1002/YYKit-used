//
//  UIButton+Additional.h
//  Demo
//
//  Created by 李永杰 on 2019/8/23.
//  Copyright © 2019 muheda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, MDButtonEdgeInsetsStyle) {
    MDButtonEdgeInsetsStyleTop,    // image在上，label在下
    MDButtonEdgeInsetsStyleLeft,   // image在左，label在右
    MDButtonEdgeInsetsStyleBottom, // image在下，label在上
    MDButtonEdgeInsetsStyleRight   // image在右，label在左
};

@interface UIButton (Additional)

- (void)layoutButtonWithEdgeInsetsStyle:(MDButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

@end

