//
//  MNAssistiveBtn.m
//  LevitationButtonDemo
//
//  Created by 梁宇航 on 2018/3/8.
//  Copyright © 2018年 xmhccf. All rights reserved.
//

#import "MNFloatBtn.h"

#define kSystemKeyboardWindowLevel 10000000

@interface MNFloatBtn()

//悬浮的按钮
@property (nonatomic, strong) MNFloatContentBtn *floatBtn;

@end

@implementation MNFloatBtn{
    
    MNAssistiveTouchType  _type;
    //拖动按钮的起始坐标点
    CGPoint _touchPoint;
    
    //起始按钮的x,y值
    CGFloat _touchBtnX;
    CGFloat _touchBtnY;

}

//static
static MNFloatBtn *_floatWindow;

static CGFloat floatBtnW = 120;
static CGFloat floatBtnH = 49;

#define screenW  [UIScreen mainScreen].bounds.size.width
#define screenH  [UIScreen mainScreen].bounds.size.height

- (MNFloatContentBtn *)floatBtn{
    if (!_floatBtn) {
        _floatBtn = [[MNFloatContentBtn alloc]init];
        
        //添加到window上
        [_floatWindow addSubview:_floatBtn];
        _floatBtn.frame = _floatWindow.bounds;
        
    }
    return _floatBtn;
}


#pragma mark - public Method
+ (UIButton *)sharedBtn{
    return _floatWindow.floatBtn;
}

+ (void)show{
    [self showWithType:MNAssistiveTypeNearRight];
}

+ (void)hidden{
    [_floatWindow setHidden:YES];
}

+ (void)showDebugMode{
#ifdef DEBUG
    [self show];
#else
#endif
}


+ (void)showDebugModeWithType:(MNAssistiveTouchType)type{
#ifdef DEBUG
    [self showWithType:type];
#else
#endif
}


+ (void)showWithType:(MNAssistiveTouchType)type{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        _floatWindow = [[MNFloatBtn alloc] initWithType:type frame:CGRectZero];
        _floatWindow.rootViewController = [[UIViewController alloc]init];
        [_floatWindow p_showFloatBtn];
    });
    
    [_floatWindow showWithType:type];
}

+ (void)setEnvironmentMap:(NSDictionary *)environmentMap
               currentEnv:(NSString *)currentEnv{
    [[self sharedBtn]setEnvironmentMap:environmentMap currentEnv:currentEnv];
}

#pragma mark - private Method
- (void)showWithType:(MNAssistiveTouchType)type{
    
    UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
    
    if (_floatWindow.hidden) {
        _floatWindow.hidden = NO;
    }
    else if (!_floatWindow) {
        _floatWindow = [[MNFloatBtn alloc] initWithType:type frame:CGRectZero];
        _floatWindow.rootViewController = [UIViewController new];
    }
    
    _floatWindow.backgroundColor = [UIColor clearColor];
    [_floatWindow makeKeyAndVisible];
    _floatWindow.windowLevel = kSystemKeyboardWindowLevel;
    
    [currentKeyWindow makeKeyWindow];
}


- (instancetype)initWithType:(MNAssistiveTouchType)type
                       frame:(CGRect)frame{

    if (self = [super init]) {
        _type = type;
        CGFloat floatBtnX = screenW - floatBtnW;
        CGFloat floatBtnY = 60;
        
        frame = CGRectMake(floatBtnX, floatBtnY, floatBtnW, floatBtnH);
        self.frame = frame;
    }
    return self;
}

- (void)p_showFloatBtn{
    self.floatBtn.hidden = NO;
}

#pragma mark - button move
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    //按钮刚按下的时候，获取此时的起始坐标
    UITouch *touch = [touches anyObject];
    _touchPoint = [touch locationInView:self];
    
    _touchBtnX = self.frame.origin.x;
    _touchBtnY = self.frame.origin.y;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:self];
    
    //偏移量(当前坐标 - 起始坐标 = 偏移量)
    CGFloat offsetX = currentPosition.x - _touchPoint.x;
    CGFloat offsetY = currentPosition.y - _touchPoint.y;
    
    //移动后的按钮中心坐标
    CGFloat centerX = self.center.x + offsetX;
    CGFloat centerY = self.center.y + offsetY;
    self.center = CGPointMake(centerX, centerY);
    
    //父试图的宽高
    CGFloat superViewWidth = screenW;
    CGFloat superViewHeight = screenH;
    CGFloat btnX = self.frame.origin.x;
    CGFloat btnY = self.frame.origin.y;
    CGFloat btnW = self.frame.size.width;
    CGFloat btnH = self.frame.size.height;
    
    //x轴左右极限坐标
    if (btnX > superViewWidth){
        //按钮右侧越界
        CGFloat centerX = superViewWidth - btnW/2;
        self.center = CGPointMake(centerX, centerY);
    }else if (btnX < 0){
        //按钮左侧越界
        CGFloat centerX = btnW * 0.5;
        self.center = CGPointMake(centerX, centerY);
    }
    
    //默认都是有导航条的，有导航条的，父试图高度就要被导航条占据，固高度不够
    CGFloat defaultNaviHeight = 64;
    CGFloat judgeSuperViewHeight = superViewHeight - defaultNaviHeight;
    
    //y轴上下极限坐标
    if (btnY <= 0){
        //按钮顶部越界
        centerY = btnH * 0.7;
        self.center = CGPointMake(centerX, centerY);
    }
    else if (btnY > judgeSuperViewHeight){
        //按钮底部越界
        CGFloat y = superViewHeight - btnH * 0.5;
        self.center = CGPointMake(btnX, y);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    CGFloat btnY = self.frame.origin.y;
    CGFloat btnX = self.frame.origin.x;
    CGFloat minDistance = 2;
    
    //结束move的时候，计算移动的距离是>最低要求，如果没有，就调用按钮点击事件
    BOOL isOverX = fabs(btnX - _touchBtnX) > minDistance;
    BOOL isOverY = fabs(btnY - _touchBtnY) > minDistance;
    
    if (isOverX || isOverY) {
        //超过移动范围就不响应点击 - 只做移动操作
        NSLog(@"move - btn");
        [self touchesCancelled:touches withEvent:event];
    }else{
        [super touchesEnded:touches withEvent:event];
        
        if (_floatBtn.btnClick) {
            _floatBtn.btnClick(_floatBtn);
        }else{
            [self changeEnv];
        }
    }
    
    //设置移动方法
    [self setMovingDirectionWithBtnX:btnX btnY:btnY];
}

- (void)setMovingDirectionWithBtnX:(CGFloat)btnX btnY:(CGFloat)btnY{
    switch (_type) {
        case MNAssistiveTypeNone:{
            //自动识别贴边
            if (self.center.x >= screenW/2) {

                [UIView animateWithDuration:0.5 animations:^{
                    //按钮靠右自动吸边
                    CGFloat btnX = screenW - floatBtnW;
                    self.frame = CGRectMake(btnX, btnY, floatBtnW, floatBtnH);
                }];
            }else{

                [UIView animateWithDuration:0.5 animations:^{
                    //按钮靠左吸边
                    CGFloat btnX = 0;
                    self.frame = CGRectMake(btnX, btnY, floatBtnW, floatBtnH);
                }];
            }
            break;
        }
        case MNAssistiveTypeNearLeft:{
            [UIView animateWithDuration:0.5 animations:^{
                //按钮靠左吸边
                CGFloat btnX = 0;
                self.frame = CGRectMake(btnX, btnY, floatBtnW, floatBtnH);
            }];
            break;
        }
        case MNAssistiveTypeNearRight:{
            [UIView animateWithDuration:0.5 animations:^{
                //按钮靠右自动吸边
                CGFloat btnX = screenW - floatBtnW;
                self.frame = CGRectMake(btnX, btnY, floatBtnW, floatBtnH);
            }];
        }
    }
}

- (void)changeEnv{
    [self.floatBtn changeEnvironment];
}

@end

