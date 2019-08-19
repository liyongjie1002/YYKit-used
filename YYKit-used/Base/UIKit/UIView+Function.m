//
//  UIView+Function.m
//  FBAllocationTracker
//
//  Created by 李永杰 on 2019/8/19.
//

#import "UIView+Function.h"
#import <objc/runtime.h>

static char *viewClickKey;

@implementation UIView (Function)

//显示小红点
- (void)showBadgeOnItemIndex:(NSInteger)index {
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];

    //新建小红点
    UIView *badgeView            = [[UIView alloc] init];
    badgeView.tag                = 888 + index;
    badgeView.layer.cornerRadius = 3.5;                //圆形
    badgeView.backgroundColor    = [UIColor redColor]; //颜色：红色
    CGRect tabFrame              = self.frame;

    //确定小红点的位置
    //    float percentX = (index +0.6) / self.tabbarItemNums;
    CGFloat x       = ceilf(tabFrame.size.width - 15);
    CGFloat y       = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 7, 7); //圆形大小为10
    [self addSubview:badgeView];
}

//隐藏小红点
- (void)hideBadgeOnItemIndex:(NSInteger)index {
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

//移除小红点
- (void)removeBadgeOnItemIndex:(NSInteger)index {
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888 + index) {
            [subView removeFromSuperview];
        }
    }
}

static char TabbarItemNums;
- (void)setTabbarItemNums:(NSInteger)tabbarItemNums {
    objc_setAssociatedObject(self, &TabbarItemNums, @(tabbarItemNums), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)tabbarItemNums {
    NSNumber *num = objc_getAssociatedObject(self, &TabbarItemNums);
    return [num integerValue];
}

- (void)maHandleClick:(UIViewClickHandle)handle {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClick:)];
    [self addGestureRecognizer:tap];
    objc_setAssociatedObject(self, &viewClickKey, handle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)viewClick:(UITapGestureRecognizer *)recognizer {
    UIViewClickHandle handle = objc_getAssociatedObject(self, &viewClickKey);
    if (handle) {
        handle(recognizer.view);
    }
}
@end
