//
//  RootViewController.m
//  NSTimer
//
//  Created by czera on 2018/7/8.
//  Copyright © 2018年 grassinfo. All rights reserved.
//

#import "RootViewController.h"
#import "TimerFirstController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"root vc";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(self.view.frame.size.width/2.0-100, self.view.frame.size.height/2.0f, 100, 40);
    btn.backgroundColor = [UIColor cyanColor];
    
    
    btn.center = self.view.center;
}

-(void)btnClicked:(id)sender{
    TimerFirstController *tf = [[TimerFirstController alloc] init];
    [self.navigationController pushViewController:tf animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TimerFirstController *timerVC = [[TimerFirstController alloc] init];
    [self.navigationController pushViewController:timerVC animated:nil];
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
