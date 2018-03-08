//
//  AssistiveTouch.h
//  LevitationButtonDemo
//
//  Created by Lyh on 2018/3/8.
//  Copyright © 2018年 xmhccf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

typedef NS_ENUM(NSInteger, MNAssistiveTouchType)
{
    MNAssistiveTouchTypeNone = 0, //没设置约束
    MNAssistiveTouchTypeTop = (1UL << 1), //距离顶部距离0
    MNAssistiveTouchTypeLeft = (1UL << 2),//距离左侧距离0
    MNAssistiveTouchTypeRight = (1UL << 3),//距离右侧距离0
    MNAssistiveTouchTypeBottom = (1UL << 4),//距离底部距离0
};

@interface MNAssistiveTouch : UIWindow

+ (instancetype)mn_touchWithFrame:(CGRect)frame;

+ (instancetype)mn_touchWithFrame:(CGRect)frame
                            title:(NSString *)title
                       titleColor:(UIColor *)titleColor
                        titleFont:(UIFont *)titleFont
                  backgroundColor:(UIColor *)backgroundColor
                  backgroundImage:(UIImage *)backgroundImage;

+ (instancetype)mn_touchWithTouchX:(CGFloat)touchX
                            touchY:(CGFloat)touchY
                            touchW:(CGFloat)touchW
                            touchH:(CGFloat)touchH
                             title:(NSString *)title
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                   backgroundColor:(UIColor *)backgroundColor
                   backgroundImage:(UIImage *)backgroundImage;


@end
