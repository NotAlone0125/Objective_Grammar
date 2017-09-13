//
//  ViewController.m
//  YYH_Block_Grammar
//
//  Created by 杨昱航 on 2017/6/12.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ViewController.h"

//使用typedef定义无返回值无参数列表的Block类型
typedef void(^SayHello)();


// 1.使用typedef定义Block类型
typedef int(^MyBlock)(int x, int y);

@interface ViewController ()
{
    int global; // 声明全局变量global
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //block的申明，跟C语言中的函数申明类似
    //void代表返回值类型，后面一次是block名，参数
    void (^blockName) (int parameter);
    
    //block的赋值，跟C语言中函数的定义类似
    blockName = ^(int a){
        NSLog(@"parameter--%d",a);
    };
    
    //block的调用
    blockName(1);
    
    
    
    
    
    // 我们可以像OC中声明变量一样使用Block类型SayHello来声明变量
    SayHello hello = ^(){
        NSLog(@"hello");
    };
    
    // 调用后控制台输出"hello"
    hello();
    
    
    
    
    //block作为函数的参数
    // 3.声明并赋值定义一个Block变量
    MyBlock addBlock = ^(int x, int y){
        return x+y;
    };
    
    // 4.以Block作为函数参数,把Block像对象一样传递
    [self useBlockForOC:addBlock];
    
    // 将第3点和第4点合并一起,以内联定义的Block作为函数参数
    [self useBlockForOC:^(int x, int y){
        return x+y;
    }];
    
    
    
    //在block中不可以修改局部变量，block中可以访问全局变量
    [self blockgrammar_1];
}
// 2.定义一个形参为Block的OC函数
- (void)useBlockForOC:(MyBlock)aBlock
{
    NSLog(@"result = %d", aBlock(300,200));
}

#pragma mark
-(void)blockgrammar_1
{
//    // 声明局部变量global
//    int a = 100;
//    
//    void(^myBlock)() = ^{
//        a ++; // 这句报错
//        NSLog(@"a = %d", a);
//    };
//    // 调用后控制台输出"a = 100"
//    myBlock();
    
    
    global=100;
    
    void(^heBlock)() = ^{
        global ++;
        NSLog(@"global = %d", global);
    };
    // 调用后控制台输出"a = 100"
    heBlock();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
