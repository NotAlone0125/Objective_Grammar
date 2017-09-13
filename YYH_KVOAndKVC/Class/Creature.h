//
//  Creature.h
//  YYH_KVOAndKVC
//
//  Created by 杨昱航 on 2017/6/13.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Creature : NSObject
{
    NSString * name;
    int hitPoint;//命中点
}

-(id)initWithName:(NSString *)str hitPoint:(int)n;

@property(nonatomic,assign)int hitPoint;

-(void)sufferDamage:(int)val;
-(NSString *)description;
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context;

@end
