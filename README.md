# MNFloatBtn

<p align="center">
<a href=""><img src="https://img.shields.io/badge/pod-v2.1.0-brightgreen.svg"></a>
<a href=""><img src="https://img.shields.io/badge/ObjectiveC-compatible-orange.svg"></a>
<a href=""><img src="https://img.shields.io/badge/platform-iOS%207.0%2B-ff69b5152950834.svg"></a>
<a href="https://github.com/miniLV"><img src="https://img.shields.io/badge/license-MIT-green.svg?style=flat"></a>
</p>

![demo示例](https://github.com/miniLV/MNFloatBtn/blob/master/Resources/demo.gif)

## Installation

#### Manually

Just add the `MNFloatBtn` folder to your project

#### CocoaPods

Use [CocoaPods](https://cocoapods.org/) with Podfile:

```
pod 'MNFloatBtn'
```

```
github "miniLV/MNFloatBtn"
```

## Usage

- The floating button is displayed in any case
```
[MNFloatBtn show];
```
<br>

- Display the floating button only in Debug mode (recommended)
```
[MNFloatBtn showDebugModeWithType:MNAssistiveTypeNone];
```
<br>

- remove floating button
```
[MNFloatBtn hidden];
```

- touch event

``` 
[MNFloatBtn sharedBtn].btnClick = ^(UIButton *sender) {

	NSLog(@" btn.btnClick ~");
    
};
```

## Advanced usage

- The current date is displayed by default

```
[[MNFloatBtn sharedBtn] setBuildShowDate:YES];
```

- Configure the api environment display

```

#define kAddress            @"testapi.miniLV.com"
//#define kAddress            @"devapi.miniLV.com"
//#define kAddress            @"api.miniLV.com"
    
//Configure yourself - what api environment, what label to display
NSDictionary *envMap = @{
                         @"test":@"testapi.miniLV.com",
                         @"dev":@"devapi.miniLV.com",
                         @"pro":@"api.miniLV.com"
                         };
                             
//Set different titles to be displayed in different environments, as well as the current Host
[[MNFloatBtn sharedBtn]setEnvironmentMap:envMap currentEnv:kAddress]; 
    
```

<br>

---

# 中文版使用说明

## 集成方法

1.CocoaPods : `pod 'MNFloatBtn'`

2.手动导入 : 拖入`MNFloatBtn`文件夹 

## 使用方法
1. 导入头文件,`#import <MNFloatBtn/MNFloatBtn.h>`
2. 一行代码,显示悬浮按钮

---
- 任何情况都显示悬浮按钮
```
[MNFloatBtn show];
```
<br>

- 仅在Debug模式下显示悬浮按钮(推荐使用)
```
[MNFloatBtn showDebugModeWithType:MNAssistiveTypeNone];
```
<br>

- 移除悬浮按钮在界面上显示
```
[MNFloatBtn hidden];
```

- 按钮点击事件

``` 
[MNFloatBtn sharedBtn].btnClick = ^(UIButton *sender) {

	NSLog(@" btn.btnClick ~");
    
};
```

---

## 进阶用法:

- 默认显示当前日期
```
[[MNFloatBtn sharedBtn] setBuildShowDate:YES];
```

- 配置api环境显示

```

#define kAddress            @"testapi.miniLV.com"
//#define kAddress            @"devapi.miniLV.com"
//#define kAddress            @"api.miniLV.com"
    
//自己配置 - 什么api环境下，要显示什么标签
NSDictionary *envMap = @{
                         @"测试":@"testapi.miniLV.com",
                         @"开发":@"devapi.miniLV.com",
                         @"生产":@"api.miniLV.com"
                         };
                             
//设置不同环境下，要展示的不同title，以及当前的Host
[[MNFloatBtn sharedBtn]setEnvironmentMap:envMap currentEnv:kAddress]; 
    
```


*如果你在天朝，可以看这篇中文博客*
[文章介绍](https://www.jianshu.com/p/5a0ca7c4fd78)
