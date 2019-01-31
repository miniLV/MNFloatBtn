//
//  NSDate+MNDate.m
//  MNFloatBtn_Example
//
//  Created by TB-Mac-107 on 2019/1/23.
//  Copyright © 2019年 miniLV. All rights reserved.
//

#import "NSDate+MNDate.h"

@implementation NSDate (MNDate)

+ (NSString *)currentDate{
    
    //获取系统时间戳
    NSDate* date1 = [NSDate date];
    NSTimeInterval time1 =[date1 timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",time1];

    //时间戳转换成时间
    NSTimeInterval time2 =[timeString doubleValue];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:time2];

    //显示的时间格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *currentTime = [formatter stringFromDate:date2];
    //NSLog(@"当前时间:%@",currentTime);
    
    return currentTime;
}

@end
