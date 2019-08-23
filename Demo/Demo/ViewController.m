//
//  ViewController.m
//  Demo
//
//  Created by 李永杰 on 2019/8/9.
//  Copyright © 2019 muheda. All rights reserved.
//

#import "ViewController.h"
#import "YYKit.h"

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
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击了" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(100, 100, 5, 5)];
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    UISwitch *sw = [[UISwitch alloc]initWithFrame:CGRectMake(100, 200, 10, 10)];
    [self.view addSubview:sw];
    [sw addTarget:self  action:@selector(clickAction1) forControlEvents:UIControlEventValueChanged];
    
}

-(void)clickAction {
    UIViewController *Vc = [self getCurrentUIVC];
    NSLog(@"%@",Vc);
}

-(void)clickAction1 {
    NSLog(@"123");
}
@end
