//
//  AssistiveTouch.m
//  LevitationButtonDemo
//
//  Created by Lyh on 2018/3/8.
//  Copyright © 2018年 xmhccf. All rights reserved.
//

#import "MNAssistiveTouch.h"

@implementation MNAssistiveTouch{
    CGFloat _touchX;
    CGFloat _touchY;
}

+ (instancetype)mn_touchWithFrame:(CGRect)frame{
    return [self mn_touchWithFrame:frame
                             title:nil
                        titleColor:nil
                         titleFont:nil
                   backgroundColor:[UIColor brownColor]
                   backgroundImage:nil];
    
}


+ (instancetype)mn_touchWithFrame:(CGRect)frame
                            title:(NSString *)title
                       titleColor:(UIColor *)titleColor
                        titleFont:(UIFont *)titleFont
                  backgroundColor:(UIColor *)backgroundColor
                  backgroundImage:(UIImage *)backgroundImage{
    
    return [self mn_touchWithTouchX:frame.origin.x
                             touchY:frame.origin.y
                             touchW:frame.size.width
                             touchH:frame.size.height
                              title:title
                         titleColor:titleColor
                          titleFont:titleFont
                    backgroundColor:backgroundColor
                    backgroundImage:backgroundImage];
    
}

+ (instancetype)mn_touchWithTouchX:(CGFloat)touchX
                            touchY:(CGFloat)touchY
                            touchW:(CGFloat)touchW
                            touchH:(CGFloat)touchH
                             title:(NSString *)title
                        titleColor:(UIColor *)titleColor
                         titleFont:(UIFont *)titleFont
                   backgroundColor:(UIColor *)backgroundColor
                   backgroundImage:(UIImage *)backgroundImage{

    return [[self alloc]initWithTouchX:touchX
                                touchY:touchY
                                touchW:touchW
                                touchH:touchH
                                 title:title
                            titleColor:titleColor
                             titleFont:titleFont
                       backgroundColor:backgroundColor
                       backgroundImage:backgroundImage];
}

- (instancetype)initWithTouchX:(CGFloat)touchX
                        touchY:(CGFloat)touchY
                        touchW:(CGFloat)touchW
                        touchH:(CGFloat)touchH
                         title:(NSString *)title
                    titleColor:(UIColor *)titleColor
                     titleFont:(UIFont *)titleFont
               backgroundColor:(UIColor *)backgroundColor
               backgroundImage:(UIImage *)backgroundImage{
    self = [super initWithFrame:CGRectMake(touchX, touchY, touchW, touchH)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //在window中显示
        [self makeKeyAndVisible];
        
        UIButton *button = [[UIButton alloc]init];
        //UIbutton的换行显示
        button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        button.backgroundColor = backgroundColor;
        button.frame = CGRectMake(0, 0, touchW, touchH);
        button.titleLabel.font = titleFont;
        [button setTitle:title forState:UIControlStateNormal];
        [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        [button setBackgroundColor:backgroundColor];
        [button addTarget:self action:@selector(clickTouchBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        //添加拖拽手势-改变控件的位置
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePostion:)];
        [button addGestureRecognizer:pan];
    }
    return self;
}


- (void)changePostion:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    CGRect originalFrame = self.frame;
    
    if (originalFrame.origin.x >= 0 && originalFrame.origin.x + originalFrame.size.width <= width) {
        
        originalFrame.origin.x += point.x;
    }
    
    if (originalFrame.origin.y >= 0 && originalFrame.origin.y + originalFrame.size.height <= height) {
        
        originalFrame.origin.y += point.y;
        
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
            
        } else if (frame.origin.x+frame.size.width > width) {
            
            frame.origin.x = width - frame.size.width;
            
            isOver = YES;
            
        }
        
        
        
        if (frame.origin.y < 0) {
            
            frame.origin.y = 0;
            
            isOver = YES;
            
        } else if (frame.origin.y+frame.size.height > height) {
            
            frame.origin.y = height - frame.size.height;
            
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

- (void)clickTouchBtn{
    NSLog(@"clickTouchBtn");
}

@end
