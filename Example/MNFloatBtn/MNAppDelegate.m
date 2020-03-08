//
//  MNAppDelegate.m
//  MNFloatBtn
//
//  Created by miniLV on 11/10/2018.
//  Copyright (c) 2018 miniLV. All rights reserved.
//

#import "MNAppDelegate.h"
#import "MNViewController.h"
#import "MNFloatBtn.h"

@implementation MNAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    MNViewController *vc = [[MNViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    //延迟加载VersionBtn - 避免wimdow还没出现就往上加控件造成的crash
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setVersionBtn];
    });
    
    return YES;
}

-(void)setVersionBtn{
    
    //是否显示系统的当天日期，如果选择NO，显示Build号
    [[MNFloatBtn sharedBtn] setBuildShowDate:YES];
    
    //#define kAddress            @"testapi.miniLV.com"
    //#define kAddress            @"devapi.miniLV.com"
    //#define kAddress            @"api.miniLV.com"
    
#ifdef DEBUG
    //如果要实现MNFloatBtn 的切换环境功能，必须这样设置
    #define kAddress [[NSUserDefaults standardUserDefaults]objectForKey:@"MNBaseUrl"]
#else
    //正式环境地址
    #define kAddress @"api.miniLV.com"
#endif
    
    NSDictionary *envMap = @{
                             @"测试":@"testapi.miniLV.com",
                             @"开发":@"devapi.miniLV.com",
                             @"生产":@"api.miniLV.com"
                             };
    
    [MNFloatBtn showDebugModeWithType:MNAssistiveTypeNone];
    
    //设置不同环境下，要展示的不同title，以及当前的Host
    NSString *baseUrl = @"api.miniLV.com";
    [MNFloatBtn setEnvironmentMap:envMap currentEnv:baseUrl];
  
    /**点击事件 - 用'[MNFloatBtn sharedBtn].btnClick'触发
     如果不需要自定义点击事件的话，可以不赋值.
     ==> 这样会实现内部的点击事件操作：点击按钮==>自动切换开发环境
     */
    
    //自定义点击事件
    //[MNFloatBtn sharedBtn].btnClick = ^(UIButton *sender) {
    //    NSLog(@" btn.btnClick ~");
    //};
}


@end
