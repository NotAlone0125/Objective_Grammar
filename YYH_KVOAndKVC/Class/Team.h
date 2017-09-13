//
//  Team.h
//  YYH_KVOAndKVC
//
//  Created by 杨昱航 on 2017/6/13.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAXMEMBER 8

@interface Team : NSObject
{
    id memebers[MAXMEMBER];
    int count;//初始值为0
}

-(NSInteger)countOfFellows;
-(void)addSomeone:(id)someone;
-(id)objectInFellowsAtIndex:(NSInteger)index;
@end
