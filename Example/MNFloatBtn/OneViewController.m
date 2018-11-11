//
//  OneViewController.m
//  LevitationButtonDemo
//
//  Created by Lyh on 2018/3/8.
//  Copyright © 2018年 xmhccf. All rights reserved.
//

#import "OneViewController.h"
#import <MNFloatBtn/MNFloatBtn.h>
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
    
}

- (void)p_removeBtn:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    sender.selected ? [MNFloatBtn hidden] : [MNFloatBtn show];
}

@end
