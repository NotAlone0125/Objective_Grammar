//
//  Person.m
//  YYH_KVOAndKVC
//
//  Created by 杨昱航 on 2017/6/12.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "Person.h"

@implementation Person

-(void)setName:(NSString *)aName
{
    NSLog(@"Access:steName:");
    name=aName;
}

-(NSString *)email
{
    NSLog(@"Access:email:");
    return email;
}

@end
