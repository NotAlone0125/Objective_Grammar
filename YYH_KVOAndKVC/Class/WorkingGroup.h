//
//  WorkingGroup.h
//  YYH_KVOAndKVC
//
//  Created by 杨昱航 on 2017/6/12.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
@interface WorkingGroup : NSObject
{
    Person * leader;
    NSMutableArray * members;
}
-(id)initWithLeader:(Person *)_leader;
-(void)addMember:(Person *)_member;
@end
