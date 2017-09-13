//
//  Person.h
//  YYH_KVOAndKVC
//
//  Created by 杨昱航 on 2017/6/12.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
{
    NSString * name;
    NSString * email;
    int _age;
}
-(void)setName:(NSString *)aName;
-(NSString *)email;
@end
