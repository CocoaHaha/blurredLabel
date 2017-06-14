//
//  BDPerson.m
//  RuntimeDemo
//
//  Created by 石向锋 on 2017/6/9.
//  Copyright © 2017年 CocoHaHa. All rights reserved.
//

#import "BDPerson.h"
#import <objc/runtime.h>

@implementation BDPerson

//@synthesize age = _age;

//初始化person属性
-(instancetype)init
{
    self = [super init];
    if(self)
    {
        name = @"Tom";
        self.age = 12;
    }
    return self;
}

//person的2个方法
-(void)func1
{
    NSLog(@"执行func1方法。");
}

-(void)func2
{
    NSLog(@"执行func2方法。");
}


//输出person对象时的方法：
-(NSString *)description
{
    return [NSString stringWithFormat:@"name:%@ age:%d",name,self.age];
}
//- (void)encodeWithCoder:(NSCoder *)encoder{
//    
//    unsigned int count = 0;
//    //获得指向该类所有属性的指针
//    objc_property_t *properties =     class_copyPropertyList([BDPerson class], &count);
//    for (int i =0; i < count; i ++) {
//        //获得
//        objc_property_t property = properties[i];        //根据objc_property_t获得其属性的名称--->C语言的字符串
//        const char *name = property_getName(property);
//        NSString *key = [NSString   stringWithUTF8String:name];
//        //      编码每个属性,利用kVC取出每个属性对应的数值
//        [encoder encodeObject:[self valueForKeyPath:key] forKey:key];
//    }
//}
//- (instancetype)initWithCoder:(NSCoder *)decoder{
//    
//    //归档存储自定义对象
//    unsigned int count = 0;
//    //获得指向该类所有属性的指针
//    objc_property_t *properties = class_copyPropertyList([BDPerson class], &count);
//    for (int i =0; i < count; i ++) {
//        objc_property_t property = properties[i];        //根据objc_property_t获得其属性的名称--->C语言的字符串
//        const char *name = property_getName(property);
//        NSString *key = [NSString stringWithUTF8String:name];        //解码每个属性,利用kVC取出每个属性对应的数值
//        [self setValue:[decoder decodeObjectForKey:key] forKeyPath:key];
//    }
//    
//    return self;
//}
@end

