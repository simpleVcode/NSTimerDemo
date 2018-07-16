//
//  TimerFirstController.m
//  NSTimer
//
//  Created by czera on 2018/7/8.
//  Copyright © 2018年 grassinfo. All rights reserved.
//

#import "TimerFirstController.h"
#import "TimerSecondController.h"
//#import <objc/runtime.h>
#import "WeekProxy.h"

@interface TimerFirstController ()
@property (nonatomic,strong) NSTimer *timer;
//@property (nonatomic,strong) id target;
@property (nonatomic,strong) WeekProxy *proxy;
@end

@implementation TimerFirstController

// 注意这个函数不能停止定时器的相关操作，这个会导致在当前界面在跳一层，会导致timer停止
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    [self.timer invalidate];
//    self.timer = nil;
//
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"TimerFirstController";
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(self.view.frame.size.width/2.0-100, self.view.frame.size.height/2.0f, 100, 40);
    btn.backgroundColor = [UIColor cyanColor];
    btn.center = self.view.center;
    
    /*
     1.这样创建 timer 会导致内存泄露
     2.这个不是循环引用 控制器没有持有 timer
     解释：scheduled 被 rouLoop 持有，所以不会释放 runLoop 持有 timer ，timer 持有 控制器（self） 导致无法释放
     循环引用会导致内存泄漏，强应用也会导致内存泄漏，timer 就是强引用导致的内存泄漏
     */
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
    /*
     使用 weakSelf 也不能解决问题
     原因：这里只是解决了self 弱引用
     */
//    __weak typeof(self) weekSelf = self;
//    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0f target:weekSelf selector:@selector(timerAction) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode: NSDefaultRunLoopMode];

    
//    // 解决方式1: 在 didMoveToParentViewController： 函数中 停止定时器
//    self.timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode: NSDefaultRunLoopMode];
    
    
//    // 解决方式2: 通过中间值进行转发 target runtime
//    _target = [NSObject new];
//    class_addMethod([_target class], @selector(timerAction),(IMP)fireIMP, "v@:");
//    self.timer = [NSTimer timerWithTimeInterval:1.0f target:_target selector:@selector(timerAction) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode: NSDefaultRunLoopMode];
    
    // 解决方式3:消息转发机制 继承NSProxy
    self.proxy = [WeekProxy alloc];
    self.proxy.target = self;
    
    self.timer = [NSTimer timerWithTimeInterval:1.0f target:self.proxy selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode: NSDefaultRunLoopMode];
}

-(void)didMoveToParentViewController:(UIViewController *)parent{
    if (nil == parent) {
        if (self.timer != nil) {
            [self.timer invalidate];
            self.timer = nil;
        }
    }
}

// 添加动态方法实现
void fireIMP(id self,SEL _cmd){
    NSLog(@"fireIMP");
}

-(void)btnClicked:(id)sender{
    TimerSecondController *tf = [[TimerSecondController alloc] init];
    [self.navigationController pushViewController:tf animated:YES];
}

-(void) timerAction {
    NSLog(@"timer Action!!");
}

-(void)dealloc{
    NSLog(@"dealloc fun !!!!!!");
    if (_timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
