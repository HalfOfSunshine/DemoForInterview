//
//  DemoForTaggerPointer.m
//  DemoForInterview
//
//  Created by kkmm on 2020/3/17.
//  Copyright © 2020 kkmm. All rights reserved.
//

#import "DemoForTaggerPointer.h"
int outerI;//常量区
int outerJ = 10;//常量区
NSObject *outerObjcA;//BSS区

@interface DemoForTaggerPointer ()
@property (nonatomic, copy) NSString *testStr;
@end

@implementation DemoForTaggerPointer

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"内存区域"];
//    [self testStorageZone];
//    [self testTaggerPointer];
    [self testNotTaggerPointer];
    // Do any additional setup after loading the view.
}

-(void)testStorageZone{
    NSLog(@"全局区中的指针outerObjcA自身的地址：%p",&outerObjcA);
    NSLog(@"outerObjcA指针所指向的堆区内存地址：%p",outerObjcA);
    outerObjcA = [[NSObject alloc]init];
    NSLog(@"常量区中的指针outerObjcA自身的地址：%p",&outerObjcA);
    NSLog(@"outerObjcA指针所指向的堆区内存地址：%p",outerObjcA);

    NSLog(@"outerI存储的常量区地址值：%p",&outerI);
    NSLog(@"outerJ存储的常量区地址值：%p",&outerJ);
    outerI = 11;
    outerJ = 11;
    NSLog(@"outerI存储的常量区地址值：%p",&outerI);
    NSLog(@"outerJ存储的常量区地址值：%p",&outerJ);
    char array[] = "aaa"; // "aaa"存放在栈区的array[]内存上
    
    char *point = "aaa"; // "aaa"存放在常量区
    char *arrayP = array; // 栈区的指针变量arrayP指向栈区的内存地址

    NSLog(@"%s",point); // aaa
    NSLog(@"%s",arrayP); // aaa
    NSLog(@"%p",point); // aaa
    NSLog(@"%p",arrayP); // aaa
    
    arrayP[1] = 'b';
    NSLog(@"%s",arrayP); // aba
    point[1] = 'b';//常量区内存中的值不可更改，崩溃
//看下面的先把这行注释
    
    
    
    char *p = "abc";//p在栈区：0x7ffee3b3af28，abc在常量区：0x101746670
    NSLog(@"指针p的栈区地址值：%p",&p);//p在栈区：0x7ffee3b3af28
    NSLog(@"指针p存储的常量区地址值：%p",p);//p指向的‘aaa’在常量区：0x101746670
    NSLog(@"pp存储的地址有+1：%p,p+1的值为：%s",p+1,p+1);
    NSLog(@"p[1]=%c",p[1]);
    p = "d";
    NSLog(@"p=%s",p);
    NSLog(@"p[1]=%c",p[1]);
    NSLog(@"p[2]=%c",p[2]);
    NSLog(@"p[3]=%c",p[3]);
    NSLog(@"p[4]=%c",p[4]);
    NSLog(@"p[5]=%c",p[5]);
    NSLog(@"p[6]=%c",p[6]);

    NSLog(@"指针p的栈区地址值：%p",&p);//p在栈区：0x7ffee3b3af28
    NSLog(@"指针p存储的常量区地址值：%p",p);//p指向的‘aaa’在常量区：0x101746670
    NSLog(@"pp存储的地址有+1：%p,p+1的值为：%s",p+1,p+1);


    char q[] = "def";
    NSLog(@"q地址值：%p 就是q存储的内存的首地址：%p",&q,q);
    NSLog(@"q有q+1：%p,q+1的值为：%s",q+1,q+1);
    
    int i;//i存放的就是那块内存，不是地址。i的内存在栈中:0x7ffee3b3af20。给i赋值,就是把0x7ffee3b3af20存储的值变成10，9，10
    NSLog(@"int i存储的地址值：%p",&i);
    i = 10;
    NSLog(@"int i存储的地址值：%p",&i);//
    i=9;
    NSLog(@"int i存储的地址值：%p",&i);//
    i=10;
    NSLog(@"int i存储的地址值：%p",&i);//

    NSObject *obj = [[NSObject alloc] init];
    NSLog(@"栈中的指针obj自身的地址：%p",&obj);
    NSLog(@"obj指针所指向的堆区的内存地址：%p",obj);
    
    UIView *view = [[UIView alloc] init];
    NSLog(@"栈中的指针view自身的地址：%p",&view);
    NSLog(@"view的指针指向了栈内存地址：%p",view);//为啥UIView指向了一个栈内存？？？？？
    
    NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:0 userInfo:nil];
    NSLog(@"栈中的指针error自身的地址：%p",&error);
    NSLog(@"error的指针指向了堆内存地址：%p",error);
}

//NSTaggedPointerString
//生成的对象占用内存小，iOS采用了TaggedPointer(指针)来进行存储
//本质上就是赋值操作，不存在release内存的操作。因此不会存在多线程问题
-(void)testTaggerPointer{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for(int i=0;i<10000;i++) {
        dispatch_async(queue, ^{
            self.testStr = [NSString stringWithFormat:@"123"];
        });
    }
}
//__NSCFString
//- (void)setTestStr:(NSString *)testStr {
//    if (_testStr != testStr) {
//        [_testStr release];
//        _testStr = [testStr copy];
//    }
//}
//第二段代码代码，其实是在调用如上的set方法，涉及多线程访问，同时执行release操作，会导致EXC_BAD_ACCESS
//当然我们可以通过for循环加锁 or 重写set方法加锁 or atomic 来解决EXC_BAD_ACCESS问题
-(void)testNotTaggerPointer{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for(int i=0;i<10000;i++) {
        dispatch_async(queue, ^{
            self.testStr = [NSString stringWithFormat:@"1234567890123"];
        });
    }
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
