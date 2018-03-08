//
//  ViewController.m
//  LevitationButtonDemo
//
//  Created by Lyh on 2018/3/8.
//  Copyright © 2018年 xmhccf. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
@interface ViewController ()

@end

@implementation ViewController

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
}

- (void)pushToNext{
    
    OneViewController *nextVC = [[OneViewController alloc]init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
