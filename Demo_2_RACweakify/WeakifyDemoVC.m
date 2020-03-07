//
//  WeakifyDemoVC.m
//  DemoForInterview
//
//  Created by kkmm on 2020/3/4.
//  Copyright © 2020 kkmm. All rights reserved.
//

#import "WeakifyDemoVC.h"
#import "Persion.h"
#import <ReactiveObjC/ReactiveObjC.h>
@interface WeakifyDemoVC ()

@end

@implementation WeakifyDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"weakify原理"];
    [self setUI];
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
-(void)test{
    Persion *obj = [Persion new];
    obj.block();
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
