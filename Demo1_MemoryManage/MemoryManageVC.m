//
//  MemoryManageVC.m
//  DemoForInterview
//
//  Created by kkmm on 2020/3/3.
//  Copyright © 2020 kkmm. All rights reserved.
//

#import "MemoryManageVC.h"
#import "NilPointerObj.h"
@interface MemoryManageVC ()

@end

@implementation MemoryManageVC

//1，内存泄漏：内存泄漏指动态分配内存的对象在使用完后没有被系统回收内存
    //(废话)：导致对象始终占有着内存,属于内存管理出错, (例如一个对象或者变量使用完成后没有释放,这个对象一直占用着内存)，一次内存泄露危害可以忽略，但内存泄露堆积后果很严重，无论多少内存,迟早会被占光。
//2，僵尸对象：一个OC对象引用计数为0被释放后就变成僵尸对象了    //：僵尸对象的内存已经被系统回收，虽然可能该对象还存在，数据依然在内存中，但僵尸对象已经是不稳定对象了，不可以再访问或者使用，它的内存是随时可能被别的对象申请而占用的。
//3，野指针：使用野指针访问僵尸对象，有的时候会出问题报错（EXC_BAD_ACCESS）,有的时候不会出问题.取决于已经释放的内存有没有被重新分配。
//https://app.yinxiang.com/fx/571e5148-63fb-424a-bf37-fcebdd487281

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testZombie]; //野指针
    [self testNilPointer];//空指针
}

//    野指针僵尸对象简单举例 需MRC环境
-(void)testZombie{
//    NSString *Str = @"我即将被回收";
//    [Str release];
//    [Str characterAtIndex:0];
}

//空指针
-(void)testNilPointer{
    NilPointerObj *obj = [NilPointerObj new];//创建实例对象
    NSLog(@"精神小伙第一次出现");
    NSLog(@"obj指向：%p",obj);
    [obj takeInterview];
    obj = nil;
    NSLog(@"精神小伙第二次出现");
    NSLog(@"obj指向：%p",obj);
    [obj takeInterview];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
