//
//  ViewController.m
//  YYH_Category
//
//  Created by 杨昱航 on 2017/6/12.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    [view logging];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
