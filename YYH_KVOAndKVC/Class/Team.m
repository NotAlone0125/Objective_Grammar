//
//  Team.m
//  YYH_KVOAndKVC
//
//  Created by 杨昱航 on 2017/6/13.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "Team.h"

@implementation Team

-(void)addSomeone:(id)someone{
    if (count<MAXMEMBER) {
        memebers[count++]=someone;
    }
}
-(NSInteger)countOfFellows
{
    return count;
}
-(id)objectInFellowsAtIndex:(NSInteger)index
{
    return (index<count)?memebers[index]:nil;
}
@end
