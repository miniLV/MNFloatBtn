//
//  MNViewController.m
//  MNFloatBtn
//
//  Created by miniLV on 11/10/2018.
//  Copyright (c) 2018 miniLV. All rights reserved.
//

#import "MNViewController.h"
#import "OneViewController.h"
@interface MNViewController ()

@end

@implementation MNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self baseSetting];
    
    [self setupUI];
}

#pragma mark - baseSetting
- (void)baseSetting{
    self.title = @"startDemo";
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - setupUI
- (void)setupUI{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(pushToNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [[UIButton alloc]init];
    [btn2 setTitle:@"show current env" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(100, 200, 200, 30);
    [btn2 setBackgroundColor:[UIColor lightGrayColor]];
    [btn2 addTarget:self action:@selector(showCurrentEnvUrl) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

- (void)showCurrentEnvUrl{
    //检验修改宏是否成功
    #define kAddress [[NSUserDefaults standardUserDefaults]objectForKey:@"MNBaseUrl"]
    NSLog(@"envUrl = %@", kAddress);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"当前API环境" message:kAddress delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)pushToNext{
    
    OneViewController *nextVC = [[OneViewController alloc]init];
    [self presentViewController:nextVC animated:YES completion:nil];
}

@end
