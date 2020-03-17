//
//  WeakifyDemoVC.m
//  DemoForInterview
//
//  Created by kkmm on 2020/3/4.
//  Copyright © 2020 kkmm. All rights reserved.
//

#import "WeakifyDemoVC.h"
#import <ReactiveObjC/ReactiveObjC.h>
#define Zlog(...) NSLog(__VA_ARGS__)
#define Link(x,n) x##n
@interface WeakifyDemoVC ()

@end

@implementation WeakifyDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"weakify原理"];
    NSString *AB = @"我是连接函数##";
    Zlog(@"打印连接函数:AB%@",Link(A, B));
    Zlog(@"标题是%@",self.title);
    [self setUI];
//    ##为连接符，A##B即为AB; ...和 __VA_ARGS__为一对 define中相互对应，表示多个参数
//    @ weakify(self);
//          ↓
//    @ + rac_keywordify + metamacro_foreach_cxt(rac_weakify_,, __weak, __VA_ARGS__)
//          ↓
//    @ + rac_keywordify + metamacro_foreach_cxt(rac_weakify_,, __weak, self)
//          ↓   注：@ rac_keywordify = @autoreleasepool {} 没用，去掉，降低理解难度
//    metamacro_foreach_cxt(rac_weakify_,, __weak, self)
//          ↓   注：metamacro_foreach_cxt(） 展开
//    metamacro_concat(metamacro_foreach_cxt, metamacro_argcount(self))(rac_weakify_,, __weak, self)
//          ↓   注：metamacro_concat = ##
//    metamacro_foreach_cxt ## metamacro_argcount(self)(rac_weakify_,, __weak, self)
//          ↓
//          ↓   注：metamacro_argcount metamacro_at1到metamacro_at20 太麻烦，请看56行单独拆解或者点进去看，作用是获取参数个数
//          ↓
//    metamacro_foreach_cxt1(rac_weakify_,, __weak, self)
//          ↓
//          ↓   注：metamacro_foreach_cxt1 - metamacro_foreach_cxt20 均有定义，请点进去看，主要看1。
//          ↓   注：metamacro_foreach_cxt1展开
//          ↓
//    rac_weakify_(0, __weak, self)
//          ↓   注：rac_weakify_展开
//    __weak __typeof__(self) metamacro_concat(self, _weak_) = (self);
//          ↓   注：metamacro_concat=连接符
//    __weak __typeof__(self) self##_weak_ = (self);
//          ↓
//          ↓最终得到
//          ↓
    __weak __typeof__(self) self_weak_ = (self);
    
    
//   解析 metamacro_concat(metamacro_foreach_cxt, metamacro_argcount(self))(rac_weakify_,, __weak, self)中的 metamacro_argcount(self)

//    metamacro_argcount(self)
//          ↓   展开
//    metamacro_at(20, self, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
//          ↓
//          ↓ 注：metamacro_at(N, ...) / metamacro_concat(metamacro_at, 20)(self, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
//          ↓
//    metamacro_at20(self, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
//          ↓
//          ↓ 注：metamacro_at20(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, ...) / metamacro_head(__VA_ARGS__) /此处细看，避免懵逼
//    metamacro_head(1)
//          ↓
//    metamacro_head_(1, 0) == metamacro_head_(FIRST, ...) == FIRST
//          ↓
//          1
    
//    metamacro_foreach_cxt1(rac_weakify_,, __weak, self) 回到41行
}

-(void)setUI{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    [button setTitle:@"test_weakify" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
//    @weakify(self);
//    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self);
//        [self.navigationController popViewControllerAnimated:YES];
//    }];
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
