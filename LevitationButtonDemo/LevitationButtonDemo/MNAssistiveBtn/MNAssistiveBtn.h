//
//  MNAssistiveBtn.h
//  LevitationButtonDemo
//
//  Created by 梁宇航 on 2018/3/8.
//  Copyright © 2018年 xmhccf. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MNAssistiveTouchType)
{
    MNAssistiveTypeNone = 0,   //自动识别贴边
    MNAssistiveTypeNearLeft,   //拖动停止之后，自动向左贴边
    MNAssistiveTypeNearRight,  //拖动停止之后，自动向右贴边
};

@interface MNAssistiveBtn : UIButton

///简单创建一个普通按钮
+ (instancetype)mn_touchWithFrame:(CGRect)frame;


/**
 创建一个可拖动按钮

 @param type 滑动类型
 @param frame 按钮的frame
 @param title 按钮的标题内容
 @param titleColor 按钮的标题颜色
 @param titleFont 按钮的标题文字大小
 @param backgroundColor 按钮的背景色
 @param backgroundImage 按钮的背景图片
 @return 可拖动按钮
 */
+ (instancetype)mn_touchWithType:(MNAssistiveTouchType)type
                           Frame:(CGRect)frame
                           title:(NSString *)title
                      titleColor:(UIColor *)titleColor
                       titleFont:(UIFont *)titleFont
                 backgroundColor:(UIColor *)backgroundColor
                 backgroundImage:(UIImage *)backgroundImage;


@end
