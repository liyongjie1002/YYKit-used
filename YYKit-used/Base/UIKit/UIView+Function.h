//
//  UIView+Function.h
//  FBAllocationTracker
//
//  Created by 李永杰 on 2019/8/19.
//

#import <UIKit/UIKit.h>

typedef void (^UIViewClickHandle)(UIView *view);

@interface UIView (Function)

- (void)showBadgeOnItemIndex:(NSInteger)index;   // 显示小红点
- (void)hideBadgeOnItemIndex:(NSInteger)index;   // 隐藏小红点
- (void)maHandleClick:(UIViewClickHandle)handle; // 添加点击事件

@end

