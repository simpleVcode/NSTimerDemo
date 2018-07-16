//
//  TestViewController.h
//  NSTimer
//
//  Created by czera on 2018/7/15.
//  Copyright © 2018年 grassinfo. All rights reserved.
//

/*
 1.静态检测方法（手动，自动）
 // 手动：product -> analyze
 // 自动：targets -> Build Settings -> Analyze During "Build" 设置成YES 每次运行都会检测
 2.动态检测方法 (Instruments , MLeaksFinder) 使用
 // MLeaksFinder 集成 不用导入任何头文件，会弹出提示 但也有缺点：目前只能检测到视图，视图控制器，内存泄漏
 3.delloc
 */

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController

@end
