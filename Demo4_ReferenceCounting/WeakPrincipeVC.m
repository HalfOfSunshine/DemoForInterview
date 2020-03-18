//
//  WeakPrincipeVC.m
//  DemoForInterview
//
//  Created by kkmm on 2020/3/18.
//  Copyright © 2020 kkmm. All rights reserved.
//

#import "WeakPrincipeVC.h"

@interface WeakPrincipeVC ()

@end

@implementation WeakPrincipeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //用 clang -rewrite-objc WeakPrincipeVC.m 把这个类编译成cpp
    NSObject *obj = [[NSObject alloc] init];
    id __weak obj1 = obj;
}

@end
