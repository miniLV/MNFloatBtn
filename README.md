# LevitationButtonDemo

![demo示例](https://github.com/miniLV/LevitationButtonDemo/blob/master/demo.gif)

*使用方法*

1. 引入‘MNAssistiveBtn’ 文件

2. 进入`AppDelegate.m` 在 ```- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {...}```方法中，添加以下代码即可
```
MNAssistiveBtn *btn = [MNAssistiveBtn mn_touchWithType:MNAssistiveTypeNone
                                                 Frame:frame
                                                 title:title
                                            titleColor:[UIColor whiteColor]
                                             titleFont:[UIFont systemFontOfSize:11]
                                       backgroundColor:nil
                                       backgroundImage:[UIImage imageNamed:@"test"]];
[self.window addSubview:btn];

```

[文章介绍](https://www.jianshu.com/p/5a0ca7c4fd78)
