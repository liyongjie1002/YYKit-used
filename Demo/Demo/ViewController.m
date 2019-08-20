//
//  ViewController.m
//  Demo
//
//  Created by 李永杰 on 2019/8/9.
//  Copyright © 2019 muheda. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Additional.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *url = @"https://mbd.baidu.com/newspage/data/landingsuper?context=手动&n_type=0&p_from=1";
    NSMutableDictionary *dic = [url parseURLParameters];
    NSLog(@"");
    
    NSString *delete = [url deleteParameterForKey:@"n_type"];
    NSLog(@"");
    
    NSDictionary *par = @{@"name":@"李永杰"};
    NSString *add = [url addParameters:par];
    NSLog(@"");
    // Do any additional setup after loading the view.
}


@end
