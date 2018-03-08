//
//  MNAssistiveBtn.m
//  LevitationButtonDemo
//
//  Created by 梁宇航 on 2018/3/8.
//  Copyright © 2018年 xmhccf. All rights reserved.
//

#import "MNAssistiveBtn.h"

#define screenW   [UIScreen mainScreen].bounds.size.width
#define screenH  [UIScreen mainScreen].bounds.size.height

@implementation MNAssistiveBtn{
    
    MNAssistiveTouchType  _type;
}

+ (instancetype)mn_touchWithFrame:(CGRect)frame{
    return [self mn_touchWithType:MNAssistiveTouchTypeNone
                            Frame:frame
                            title:nil
                       titleColor:nil
                        titleFont:nil
                  backgroundColor:[UIColor orangeColor]
                  backgroundImage:nil];
}


+ (instancetype)mn_touchWithType:(MNAssistiveTouchType)type
                           Frame:(CGRect)frame
                           title:(NSString *)title
                      titleColor:(UIColor *)titleColor
                       titleFont:(UIFont *)titleFont
                 backgroundColor:(UIColor *)backgroundColor
                 backgroundImage:(UIImage *)backgroundImage{
    
    return [[self alloc]initWithType:type
                               frame:frame
                               title:title
                          titleColor:titleColor
                           titleFont:titleFont
                     backgroundColor:backgroundColor
                     backgroundImage:backgroundImage];
}

- (instancetype)initWithType:(MNAssistiveTouchType)type
                       frame:(CGRect)frame
                       title:(NSString *)title
                  titleColor:(UIColor *)titleColor
                   titleFont:(UIFont *)titleFont
             backgroundColor:(UIColor *)backgroundColor
             backgroundImage:(UIImage *)backgroundImage{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *button = [[UIButton alloc]init];
        //UIbutton的换行显示
        button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        button.backgroundColor = backgroundColor;
        button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        button.titleLabel.font = titleFont;
        [button setTitle:title forState:UIControlStateNormal];
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        [button setBackgroundColor:backgroundColor];
        
        [self addSubview:button];
        //添加拖拽手势-改变控件的位置
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePostion:)];
        [button addGestureRecognizer:pan];
    }
    return self;
}


- (void)changePostion:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self];

    CGRect originalFrame = self.frame;
    switch (_type) {
        case MNAssistiveTouchTypeNone:
        {
            originalFrame = [self changeXWithFrame:originalFrame point:point];
            originalFrame = [self changeYWithFrame:originalFrame point:point];
            break;
        }case MNAssistiveTouchTypeHorizontalScroll:{
            originalFrame = [self changeYWithFrame:originalFrame point:point];
            break;
        }
        case MNAssistiveTouchTypeVerticalScroll:{
            originalFrame = [self changeXWithFrame:originalFrame point:point];
            break;
        }
    }

    self.frame = originalFrame;
    
    [pan setTranslation:CGPointZero inView:self];
    
    UIButton *button = (UIButton *)pan.view;
    if (pan.state == UIGestureRecognizerStateBegan) {
        button.enabled = NO;
    }else if (pan.state == UIGestureRecognizerStateChanged){
        
    } else {
        CGRect frame = self.frame;
        
        //记录是否越界
        BOOL isOver = NO;
        if (frame.origin.x < 0) {
            
            frame.origin.x = 0;
            
            isOver = YES;
            
        } else if (frame.origin.x+frame.size.width > screenW) {
            
            frame.origin.x = screenW - frame.size.width;
            
            isOver = YES;
            
        }
        
        
        
        if (frame.origin.y < 0) {
            
            frame.origin.y = 0;
            
            isOver = YES;
            
        } else if (frame.origin.y+frame.size.height > screenH) {
            
            frame.origin.y = screenH - frame.size.height;
            
            isOver = YES;
            
        }
        
        if (isOver) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                self.frame = frame;
            }];
        }
        button.enabled = YES;
    }
}

- (CGRect)changeXWithFrame:(CGRect)originalFrame point:(CGPoint)point{
    BOOL q1 = originalFrame.origin.x >= 0;
    BOOL q2 = originalFrame.origin.x + originalFrame.size.width <= screenW;
    
    if (q1 && q2) {
        originalFrame.origin.x += point.x;
    }
    return originalFrame;
}

- (CGRect)changeYWithFrame:(CGRect)originalFrame point:(CGPoint)point{
    
    BOOL q1 = originalFrame.origin.y >= 0;
    BOOL q2 = originalFrame.origin.y + originalFrame.size.height <= screenH;
    if (q1 && q2) {
        originalFrame.origin.y += point.y;
    }
    return originalFrame;
}

@end
