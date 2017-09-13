//
//  UIView+Logging.m
//  YYH_Category
//
//  Created by 杨昱航 on 2017/6/12.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "UIView+Logging.h"

@implementation UIView (Logging)

/*
 1.类别的接口部分必须引用主文件的接口文件
 2.类别的实现部分必须引用对应的接口文件
 3.使用类别中的方法必须引用这个方法锁所在的头文件
 */


//类别的功能  分散类的实现，扩展类的实例方法
-(void)logging
{
    NSLog(@"我是UIview的类别");
}

@end
