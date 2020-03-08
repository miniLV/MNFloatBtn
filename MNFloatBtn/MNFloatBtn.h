//
//  MNAssistiveBtn.h
//  LevitationButtonDemo
//
//  Created by 梁宇航 on 2018/3/8.
//  Copyright © 2018年 xmhccf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNFloatContentBtn.h"

typedef NS_ENUM(NSInteger, MNAssistiveTouchType)
{
    MNAssistiveTypeNone = 0,   //自动识别贴边
    MNAssistiveTypeNearLeft,   //拖动停止之后，自动向左贴边
    MNAssistiveTypeNearRight,  //拖动停止之后，自动向右贴边
};

@interface MNFloatBtn : UIWindow

//任何模式都显示floatBtn
+ (void)show;

//仅在Debug模式下显示floatBtn(**推荐这种设置，防止floatBtn跑生产环境上**)
+ (void)showDebugMode;

//Debug模式下都显示floatBtn - 并设置float吸附设置
+ (void)showDebugModeWithType:(MNAssistiveTouchType)type;

//移除floatBtn在界面显示
+ (void)hidden;

//获取floatBtn对象
+ (MNFloatContentBtn *)sharedBtn;

/**
 做的环境映射
 
 比如
 dev - https://miniDev.com
 qa  - https://miniQA.com
 pro - https://miniPro.com
 
 {
 @"开发":miniDev,
 @"测试":miniQA,
 @"生产":miniPro,
 }
 
 @param environmentMap 环境 - Host 的 映射
 @param currentEnv - 当前环境的Host
 */
+ (void)setEnvironmentMap:(NSDictionary *)environmentMap
               currentEnv:(NSString *)currentEnv;

@end



