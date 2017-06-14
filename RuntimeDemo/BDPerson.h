//
//  BDPerson.h
//  RuntimeDemo
//
//  Created by 石向锋 on 2017/6/9.
//  Copyright © 2017年 CocoHaHa. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BDPerson : NSObject
{
    NSString *name;
}
//@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) int age;

-(void)func1;
-(void)func2;

//- (void)encodeWithCoder:(NSCoder *)encoder;
//- (instancetype)initWithCoder:(NSCoder *)decoder;

@end
