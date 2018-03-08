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
    MNAssistiveTouchTypeNone = 0,         //没可以随便移动
    MNAssistiveTouchTypeVerticalScroll,   //只能垂直移动
    MNAssistiveTouchTypeHorizontalScroll, //只能竖直移动
};

@interface MNAssistiveBtn : UIButton

+ (instancetype)mn_touchWithFrame:(CGRect)frame;

+ (instancetype)mn_touchWithType:(MNAssistiveTouchType)type
                           Frame:(CGRect)frame
                           title:(NSString *)title
                      titleColor:(UIColor *)titleColor
                       titleFont:(UIFont *)titleFont
                 backgroundColor:(UIColor *)backgroundColor
                 backgroundImage:(UIImage *)backgroundImage;


@end
