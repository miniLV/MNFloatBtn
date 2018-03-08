//
//  AppDelegate.m
//  LevitationButtonDemo
//
//  Created by Lyh on 2018/3/8.
//  Copyright © 2018年 xmhccf. All rights reserved.
//

#import "AppDelegate.h"
#import "MNAssistiveTouch.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navi;
    
    // 这句话很重要，要先将rootview加载完成之后在显示悬浮框，如没有这句话，将可能造成程序崩溃
    [self performSelector:@selector(setNew) withObject:nil afterDelay:1];

    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)setNew
{

    CGFloat touchW = 120;
    CGFloat touchX = 375 - touchW;
    CGFloat touchY = 43;
    CGFloat touchH = 49;
    
    NSString *versionStr = [[[NSBundle
       mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"];
    NSString *buildStr = [[[NSBundle
       mainBundle]infoDictionary]valueForKey:@"CFBundleVersion"];
    
    NSString *title = [NSString stringWithFormat:@"Ver:%@ 测试\nBuild:%@",versionStr,buildStr];
    //最基础的框框
//    MNAssistiveTouch *win = [MNAssistiveTouch mn_touchWithFrame:CGRectMake(touchX, touchY, touchW, touchH)];
//    MNAssistiveTouch *win = [MNAssistiveTouch mn_touchWithTouchX:touchX
//                                                          touchY:touchY
//                                                          touchW:touchW
//                                                          touchH:touchH
//                                                           title:title
//                                                      titleColor:[UIColor whiteColor]
//                                                       titleFont:[UIFont systemFontOfSize:11]
//                                                 backgroundColor:[UIColor lightGrayColor]
//                                                 backgroundImage:nil];

    MNAssistiveTouch *win = [MNAssistiveTouch mn_touchWithTouchX:touchX
                                                          touchY:touchY
                                                          touchW:touchW
                                                          touchH:touchH
                                                           title:title
                                                      titleColor:[UIColor whiteColor]
                                                       titleFont:[UIFont systemFontOfSize:11]
                                                 backgroundColor:nil
                                                 backgroundImage:[UIImage imageNamed:@"test"]];
    
    [self.window addSubview:win];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
