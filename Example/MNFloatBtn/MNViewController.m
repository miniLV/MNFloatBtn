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
}

- (void)pushToNext{
    
    OneViewController *nextVC = [[OneViewController alloc]init];
    [self presentViewController:nextVC animated:YES completion:nil];
}

@end
