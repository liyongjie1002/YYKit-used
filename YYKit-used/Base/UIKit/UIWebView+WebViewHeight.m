//
//  UIWebView+WebViewHeight.m
//  MHDShop
//
//  Created by 李永杰 on 2019/4/17.
//  Copyright © 2019 LWH. All rights reserved.
//

#import "UIWebView+WebViewHeight.h"

@implementation UIWebView (WebViewHeight)
-(float)webHeight {
    
    NSString * clientheight_str = [self stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
    float clientheight = [clientheight_str floatValue];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, clientheight);
    CGSize frame = [self sizeThatFits:self.frame.size];
    // 获取内容实际高度（像素）
    // 这是因为webview加载完之后容量固定了，但是适配之后实际内容高度变小了，留出了一片空白。这个时候需要再次调用JS调整页面高度
    NSString * height_str= [self stringByEvaluatingJavaScriptFromString: @"document.getElementById('img_box').offsetHeight + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-top'))  + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-bottom'))"];
    float height = [height_str floatValue];
    if(height>0 && clientheight>0)
    {
        //内容实际高度（像素）* 点和像素的比
        height = height * frame.height / clientheight;
        return height;
    }
    return 0;
}

@end
