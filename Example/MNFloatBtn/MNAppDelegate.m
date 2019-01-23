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
    
    [[MNFloatBtn sharedBtn] setBuildShowDate:NO];
    [MNFloatBtn showDebugModeWithType:MNAssistiveTypeNone];

    //#define kAddress            @"testapi.miniLV.com"
    //#define kAddress            @"devapi.miniLV.com"
    //#define kAddress            @"api.miniLV.com"
    NSDictionary *envMap = @{
                             @"测试":@"testapi.miniLV.com",
                             @"开发":@"devapi.miniLV.com",
                             @"生产":@"api.miniLV.com"
                             };
    [[MNFloatBtn sharedBtn]setEnvironmentMap:envMap];
    
    
    [MNFloatBtn sharedBtn].btnClick = ^(UIButton *sender) {

        NSLog(@" btn.btnClick ~");
    };
}

@end
