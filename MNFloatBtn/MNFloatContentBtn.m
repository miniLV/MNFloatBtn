//
//  MNFloatContentBtn.m
//  MNFloatBtn
//
//  Created by Tyrion Liang on 2020/3/7.
//

#import "MNFloatContentBtn.h"
#import "NSDate+MNDate.h"
#import "MNFloatBtn.h"

@interface MNFloatContentBtn()

//是否显示当前日期
@property (nonatomic, assign, getter=isBuildShowDate) BOOL buildShowDate;

//Build号
@property(nonatomic, copy)NSString *buildStr;

//当前展示的环境
@property (nonatomic, copy)NSString *environmentStr;

@property (nonatomic, copy)NSDictionary *environmentMap;

@end

@implementation MNFloatContentBtn

//系统默认build
#define MNFloatBtnSystemBuild [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleVersion"]
//系统默认version
#define MNFloatBtnSystemVersion [[[NSBundle mainBundle]infoDictionary]valueForKey:@"CFBundleShortVersionString"]


#pragma mark - lazy
- (NSString *)buildStr{
    if (!_buildStr) {
        _buildStr = [NSDate currentDate];
    }
    return _buildStr;
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        UIImage *image = [self p_loadResourceImage];
        
        //获取build的值
        [self p_getBuildStr];
        
        NSString *title = [NSString stringWithFormat:@"Ver:%@ %@\nBuild:%@",MNFloatBtnSystemVersion,self.environmentStr, self.buildStr];
        
        //UIbutton的换行显示
        self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        [self setTitle:title forState:UIControlStateNormal];
        [self setBackgroundImage:image forState:UIControlStateNormal];

    }
    return self;
}

#pragma mark - set Method
- (void)setBuildShowDate:(BOOL)isBuildShowDate{
    _buildShowDate = isBuildShowDate;
    
    [self p_getBuildStr];
    
    [self p_updateBtnTitle];
}

- (void)changeEnvironment{

    NSArray *envKeys = self.environmentMap.allKeys;
    NSInteger currentIndex = 0;
    if ([envKeys containsObject:self.environmentStr]) {
        currentIndex = [envKeys indexOfObject:self.environmentStr];
    }
    NSInteger nextEnvIndex = (currentIndex + 1) % envKeys.count;
    self.environmentStr = envKeys[nextEnvIndex];
    [self p_updateBtnTitle];
    
    NSString *envBaseUrl = self.environmentMap[self.environmentStr];
    
    NSString *saveBaseUrlKey = @"MNBaseUrl";
    [[NSUserDefaults standardUserDefaults]setObject:envBaseUrl forKey:saveBaseUrlKey];
}

- (void)setEnvironmentMap:(NSDictionary *)environmentMap
               currentEnv:(NSString *)currentEnv{
    
    __block NSString *envStr = @"测试";
    
    [environmentMap enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([currentEnv isEqualToString:obj]) {
            envStr = key;
            *stop = YES;
        }
    }];
    
    self.environmentStr = envStr;
    self.environmentMap = environmentMap;
    [self p_updateBtnTitle];
}


//获取build展示内容
- (void)p_getBuildStr{
    NSString *buildStr = [NSDate currentDate];
    if (!self.isBuildShowDate) {
        buildStr = MNFloatBtnSystemBuild;
    }
    self.buildStr = buildStr;
}

- (void)p_updateBtnTitle{
    
    NSString *title = [NSString stringWithFormat:@"Ver:%@ %@\nBuild:%@",MNFloatBtnSystemVersion,self.environmentStr, self.buildStr];
    
    //如果createBtn的时候直接改title，可能会出现title无法更新问题，所以加个0.01s的延迟函数
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setTitle:title forState:UIControlStateNormal];
    });
}

- (NSString *)environmentStr{
    if (!_environmentStr) {
        _environmentStr = @"测试";
    }
    return _environmentStr;
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
