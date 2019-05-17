//
//  OneViewController.m
//  LevitationButtonDemo
//
//  Created by Lyh on 2018/3/8.
//  Copyright © 2018年 xmhccf. All rights reserved.
//

#import "OneViewController.h"
#import "MNFloatBtn.h"
@interface OneViewController ()

@end

@implementation OneViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"nextVC";
    UIColor *randomColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    self.view.backgroundColor = randomColor;
    
    UIButton *removeBtn = [[UIButton alloc]init];
    removeBtn.frame = CGRectMake(0, 100, 150, 40);
    [removeBtn setTitle:@"remove" forState:UIControlStateNormal];
    [removeBtn setTitle:@"show" forState:UIControlStateSelected];
    [removeBtn addTarget:self action:@selector(p_removeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeBtn];
    
    //弹框测试
    UIButton *alertBtn = [[UIButton alloc]init];
    alertBtn.frame = CGRectMake(0, 200, 150, 40);
    [alertBtn setTitle:@"alert" forState:UIControlStateNormal];
    [alertBtn addTarget:self action:@selector(p_alertBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alertBtn];
    
    //window添加一个测试view
    UIButton *windowTestBtn = [[UIButton alloc]init];
    windowTestBtn.frame = CGRectMake(0, 300, 150, 40);
    [windowTestBtn setTitle:@"windowTestBtn" forState:UIControlStateNormal];
    [windowTestBtn addTarget:self action:@selector(p_windowTestBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:windowTestBtn];
}

- (void)p_removeBtn:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    sender.selected ? [MNFloatBtn hidden] : [MNFloatBtn show];
}

- (void)p_alertBtn{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"test" message:@"test message" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alertView dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertView animated:YES completion:nil];
}

- (void)p_windowTestBtn{
 
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *testView = [[UIView alloc]init];
    testView.backgroundColor = [UIColor lightGrayColor];
    testView.frame = CGRectMake(0, 400, 200, 400);
    [window addSubview:testView];
    
}

@end
