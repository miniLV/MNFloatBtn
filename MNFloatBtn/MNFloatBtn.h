//
//  MNAssistiveBtn.h
//  LevitationButtonDemo
//
//  Created by 梁宇航 on 2018/3/8.
//  Copyright © 2018年 xmhccf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MNFloatContentBtn;

typedef NS_ENUM(NSInteger, MNAssistiveTouchType)
{
    MNAssistiveTypeNone = 0,   //自动识别贴边
    MNAssistiveTypeNearLeft,   //拖动停止之后，自动向左贴边
    MNAssistiveTypeNearRight,  //拖动停止之后，自动向右贴边
};

@interface MNFloatBtn : UIWindow

typedef void (^floatBtnClick)(UIButton *sender);

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

//按钮点击事件
//@property (nonatomic, copy)floatBtnClick btnClick;





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
//- (void)setEnvironmentMap:(NSDictionary *)environmentMap currentEnv:(NSString *)currentEnv;

@end


@interface MNFloatContentBtn : UIButton

/**
 Build是否显示当天日期 - 默认是
 如果传NO - Build 显示 系统的Build - 需手动更新
 如果传YES - 字段识别今天的日期
 */
- (void)setBuildShowDate:(BOOL)isBuildShowDate;

////按钮点击事件
//@property (nonatomic, copy)floatBtnClick btnClick;

- (void)setEnvironmentMap:(NSDictionary *)environmentMap currentEnv:(NSString *)currentEnv;


@property (nonatomic, copy)floatBtnClick btnClick;


@end


