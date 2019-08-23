//
//  UIButton+Additional.m
//  Demo
//
//  Created by 李永杰 on 2019/8/23.
//  Copyright © 2019 muheda. All rights reserved.
//

#import "UIButton+Additional.h"

@implementation UIButton (Additional)

- (void)layoutButtonWithEdgeInsetsStyle:(MDButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space {

    CGFloat imageWith   = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    CGFloat labelWidth  = 0.0;
    CGFloat labelHeight = 0.0;

    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        labelWidth  = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth  = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }

    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;

    switch (style) {
        case MDButtonEdgeInsetsStyleTop: {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - space / 2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight - space / 2.0, 0);
        } break;
        case MDButtonEdgeInsetsStyleLeft: {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0);
        } break;
        case MDButtonEdgeInsetsStyleBottom: {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight - space / 2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight - space / 2.0, -imageWith, 0, 0);
        } break;
        case MDButtonEdgeInsetsStyleRight: {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + space / 2.0, 0, -labelWidth - space / 2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith - space / 2.0, 0, imageWith + space / 2.0);
        } break;
        default:
            break;
    }

    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

//扩大button点击热区
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta  = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds              = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end
