//
//  MNAssistiveBtn.m
//  LevitationButtonDemo
//
//  Created by 梁宇航 on 2018/3/8.
//  Copyright © 2018年 xmhccf. All rights reserved.
//

#import "MNFloatBtn.h"

#define screenW  [UIScreen mainScreen].bounds.size.width
#define screenH  [UIScreen mainScreen].bounds.size.height

@implementation MNFloatBtn{
    
    MNAssistiveTouchType  _type;
    //拖动按钮的起始坐标点
    CGPoint _touchPoint;
    
    //起始按钮的x,y值
    CGFloat _touchBtnX;
    CGFloat _touchBtnY;
}

static MNFloatBtn *_floatBtn;

static CGFloat floatBtnW = 120;
static CGFloat floatBtnH = 49;

+ (instancetype)getFloatBtn{
    if (!_floatBtn) {
        _floatBtn = [[self alloc]initWithType:MNAssistiveTypeNearRight frame:CGRectZero];
    }
    return _floatBtn;
}

+ (void)show{
    
    [self showWithType:MNAssistiveTypeNearRight];
}

+ (void)hidden{
    
    [_floatBtn removeFromSuperview];
}

+ (void)showDebugMode{
    
#ifdef DEBUG
    [self show];
#else
#endif
}

+ (void)showWithType:(MNAssistiveTouchType)type{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _floatBtn = [[MNFloatBtn alloc] initWithType:MNAssistiveTypeNearRight frame:CGRectZero];
    });
    
    if (!_floatBtn.superview) {
        
        [[UIApplication sharedApplication].keyWindow addSubview:_floatBtn];
        //让floatBtn在最上层(即便以后还有keywindow add subView，也会在 floatBtn下)
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_floatBtn];
    }
}


- (instancetype)initWithType:(MNAssistiveTouchType)type
                       frame:(CGRect)frame{
    
    if (CGRectEqualToRect(frame, CGRectZero)) {
        CGFloat floatBtnX = screenW - floatBtnW;
        CGFloat floatBtnY = 60;
        
        frame = CGRectMake(floatBtnX, floatBtnY, floatBtnW, floatBtnH);
    }
    NSString *versionStr = [[[NSBundle
                              mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"];
    NSString *buildStr = [[[NSBundle
                            mainBundle]infoDictionary]valueForKey:@"CFBundleVersion"];
    
    NSString *title = [NSString stringWithFormat:@"Ver:%@ 测试\nBuild:%@",versionStr,buildStr];
    
    UIImage *image = [self p_loadResourceImage];
    
    
    
    NSLog(@"path = %@, image = %@",path,image);
    return [self initWithType:type
                        frame:frame
                        title:title
                   titleColor:[UIColor whiteColor]
                    titleFont:[UIFont systemFontOfSize:11]
              backgroundColor:nil
              backgroundImage:image];
}

- (instancetype)initWithType:(MNAssistiveTouchType)type
                       frame:(CGRect)frame
                       title:(NSString *)title
                  titleColor:(UIColor *)titleColor
                   titleFont:(UIFont *)titleFont
             backgroundColor:(UIColor *)backgroundColor
             backgroundImage:(UIImage *)backgroundImage{
    
    if (self = [super initWithFrame:frame]) {
        _type = type;
        
        //UIbutton的换行显示
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.backgroundColor = backgroundColor;
        self.titleLabel.font = titleFont;
        [self setTitle:title forState:UIControlStateNormal];
        [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        [self setBackgroundColor:backgroundColor];
        
        [self addTarget:self action:@selector(p_clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)p_clickBtn:(UIButton *)sender{
    
    if (_btnClick) {
        _btnClick(sender);
    }
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
    CGFloat superViewWidth = self.superview.frame.size.width;
    CGFloat superViewHeight = self.superview.frame.size.height;
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
    
    CGFloat btnWidth = self.frame.size.width;
    CGFloat btnHeight = self.frame.size.height;
    CGFloat btnY = self.frame.origin.y;
    CGFloat btnX = self.frame.origin.x;
    
    CGFloat minDistance = 2;
    
    //结束move的时候，计算移动的距离是>最低要求，如果没有，就调用按钮点击事件
    BOOL isOverX = fabs(btnX - _touchBtnX) > minDistance;
    BOOL isOverY = fabs(btnY - _touchBtnY) > minDistance;
    
    if (isOverX || isOverY) {
        //超过移动范围就不响应点击 - 只做移动操作
        [self touchesCancelled:touches withEvent:event];
    }else{
        [super touchesEnded:touches withEvent:event];
    }
    
    //按钮靠近右侧
    switch (_type) {
            
        case MNAssistiveTypeNone:{
            
            //自动识别贴边
            if (self.center.x >= self.superview.frame.size.width/2) {
                
                [UIView animateWithDuration:0.5 animations:^{
                    //按钮靠右自动吸边
                    CGFloat btnX = self.superview.frame.size.width - btnWidth;
                    self.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
                }];
            }else{
                
                [UIView animateWithDuration:0.5 animations:^{
                    //按钮靠左吸边
                    CGFloat btnX = 0;
                    self.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
                }];
            }
            break;
        }
        case MNAssistiveTypeNearLeft:{
            [UIView animateWithDuration:0.5 animations:^{
                //按钮靠左吸边
                CGFloat btnX = 0;
                self.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
            }];
            break;
        }
        case MNAssistiveTypeNearRight:{
            [UIView animateWithDuration:0.5 animations:^{
                //按钮靠右自动吸边
                CGFloat btnX = self.superview.frame.size.width - btnWidth;
                self.frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
            }];
        }
    }
}

#pragma mark - loadResourceImage
- (UIImage *)p_loadResourceImage{
    
    NSBundle *bundle = [NSBundle bundleForClass:[MNFloatBtn class]];
    
    NSURL *url = [bundle URLForResource:@"MNFloatBtn" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    
    NSString *path = [imageBundle pathForResource:@"mn_placeholder@3x" ofType:@"png"];
    
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    return image;
}


@end
