//
//  WeekProxy.m
//  NSTimer
//
//  Created by czera on 2018/7/15.
//  Copyright © 2018年 grassinfo. All rights reserved.
//

#import "WeekProxy.h"

@implementation WeekProxy

// 重写方法签名，设置转发对象
- (NSMethodSignature *) methodSignatureForSelector:(SEL)sel{
    return [self.target methodSignatureForSelector:sel];
}

// 转发
-(void)forwardInvocation:(NSInvocation *)invocation{
    [invocation invokeWithTarget:self.target];
}

@end
