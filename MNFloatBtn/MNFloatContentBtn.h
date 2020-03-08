//
//  MNFloatContentBtn.h
//  MNFloatBtn
//
//  Created by Tyrion Liang on 2020/3/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^floatBtnClick)(UIButton *sender);

@interface MNFloatContentBtn : UIButton

/**
 Build是否显示截屏当天日期
 如果传NO - Build 显示 系统的Build - 需手动更新
 如果传YES - 字段识别今天的日期
 */
- (void)setBuildShowDate:(BOOL)isBuildShowDate;

- (void)setEnvironmentMap:(NSDictionary *)environmentMap currentEnv:(NSString *)currentEnv;

- (void)changeEnvironment;

//按钮点击事件
@property (nonatomic, copy)floatBtnClick btnClick;

@end

NS_ASSUME_NONNULL_END
