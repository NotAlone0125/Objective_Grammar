//
//  WorkingGroup.m
//  YYH_KVOAndKVC
//
//  Created by 杨昱航 on 2017/6/12.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "WorkingGroup.h"

@implementation WorkingGroup

-(id)initWithLeader:(Person *)_leader
{
    if (self==[super init])
    {
        leader=_leader;
        members=[NSMutableArray arrayWithCapacity:0];
    }
    return self;
}
-(void)addMember:(Person *)_member
{
    [members addObject:_member];
}
@end
