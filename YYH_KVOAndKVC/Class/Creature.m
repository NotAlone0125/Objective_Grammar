//
//  Creature.m
//  YYH_KVOAndKVC
//
//  Created by 杨昱航 on 2017/6/13.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "Creature.h"

@implementation Creature

-(id)initWithName:(NSString *)str hitPoint:(int)n
{
    if (self=[super init])
    {
        name=str;
        hitPoint=n;
    }
    return self;
}

@synthesize hitPoint;

-(void)sufferDamage:(int)val
{
    //受伤后命中点降低
    hitPoint=(hitPoint>val)?(hitPoint-val):0;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"<<%@,%@,HP=%d>>",NSStringFromClass([self class]),name,hitPoint];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    //接收键值观察的通知
    printf("%s",[[NSString stringWithFormat:@"___Received by %@ ---\n"@"Object=%@,Path=%@\n"@"Change=%@\n",self,object,keyPath,change] UTF8String]);
}
@end





