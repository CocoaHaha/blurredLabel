//
//  ViewController.m
//  RuntimeDemo
//
//  Created by 石向锋 on 2017/6/9.
//  Copyright © 2017年 CocoHaHa. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "BDPerson.h"
#import "BDPerson+PersonCategory.h"
@interface ViewController ()
{
    BDPerson *person;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    person = [[BDPerson alloc]init];//初始化
    
}
/*1.获取BDPerson所有的成员变量*/
- (IBAction)getAllVariable:(id)sender {
    unsigned int count = 0;
    //获取类的一个包含所有属性变量的列表，IVar是runtime声明的一个宏，是实例变量的意思.
    Ivar *allVariables = class_copyIvarList([BDPerson class], &count);
    
    for(int i = 0;i<count;i++)
    {
        //遍历每一个变量，包含名称和类型（此处没有"*"）
        Ivar ivar = allVariables[i];
        const char *Variablename = ivar_getName(ivar);          //获取成员变量名称
        const char *VariableType  = ivar_getTypeEncoding(ivar); //获取成员变量类型
        NSLog(@"(Name: %s) ----- (Type:%s)",Variablename,VariableType);
    }
}
/*2.获取BDPerson所有的属性*/
- (IBAction)getAllProperty:(id)sender {
    
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([BDPerson class], &count);
    
    for (int i =0; i < count; i ++) {
        
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"%d----%@",i,key);
    }
}
/*3.获取BDPerson所有方法*/
- (IBAction)getAllMethod:(id)sender {
    unsigned int count;
    //获取方法列表，所有在.m文件显式实现的方法都会被找到，包括setter+getter方法：
    Method *allMethods = class_copyMethodList([BDPerson class], &count);
    for(int i =0;i<count;i++)
    {
        //Method：runtime声明的一个宏，表示一个方法
        Method md = allMethods[i];
        //获取SEL：SEL类型,即获取方法选择器@selector()
        SEL sel = method_getName(md);
        //得到sel的方法名：以字符串格式获取sel的name，也即@selector()中的方法名称
        const char *methodname = sel_getName(sel);
        NSLog(@"(Method:%s)",methodname);
    }
}
/*4.改变BDPerson的name变量属性*/
- (IBAction)changeVariable:(id)sender {
    NSLog(@"改变前的person：%@",person);
    
    unsigned int count = 0;
    Ivar *allList = class_copyIvarList([BDPerson class], &count);
    
    //从第一个方法getAllVariable中输出的控制台信息，我们可以看到name为第一个实例属性；
    Ivar ivv = allList[0];
    //name属性Tom被强制改为Mike。
    object_setIvar(person, ivv, @"Mike");
    NSLog(@"改变之后的person：%@",person);
}
/* 5.添加新的属性*/
- (IBAction)addVariable:(id)sender {
    person.height = 12;           //给新属性height赋值
    NSLog(@"%f",[person height]); //访问新属性值
}
/*6.添加新的方法试试(这种方法等价于对Father类添加Category对方法进行扩展)：*/
- (IBAction)addMethod:(id)sender {
    class_addMethod([BDPerson class], @selector(NewMethod), (IMP)myAddingFunction, 0);
    
    //调用 【如果使用[per method]方法！(在ARC下会报no visible @interface 错误)】
    [person performSelector:@selector(NewMethod)];
}
/*此方法没有执行*/
- (void)NewMethod{
    
    NSLog(@"新增加的方法哈哈哈哈 没用的");
    
}
//具体的实现（方法的内部都默认包含两个参数Class类和SEL方法，被称为隐式参数。）
int myAddingFunction(id self, SEL _cmd)
{
    NSLog(@"已新增方法:NewMethod");
    return 1;
}
/*7.交换两种方法之后（功能对调），可以试试让苹果乱套 */
- (IBAction)replaceMethod:(id)sender {
    
    Method method1 = class_getInstanceMethod([BDPerson class], @selector(func1));
    Method method2 = class_getInstanceMethod([BDPerson class], @selector(func2));
    method_exchangeImplementations(method1, method2);
    [person func1];  //输出交换后的效果，需要对比的可以尝试下交换前运行func1；
    [person func2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
