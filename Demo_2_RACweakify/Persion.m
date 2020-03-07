//
//  Persion.m
//  DemoForInterview
//
//  Created by kkmm on 2020/3/7.
//  Copyright © 2020 kkmm. All rights reserved.
//

#import "Persion.h"
#import <ReactiveObjC/ReactiveObjC.h>


@implementation Persion
- (void)dealloc {
    NSLog(@"%s",__func__);}

- (instancetype)init {
    self = [super init];
    if (self) {
        @weakify(self);
        self.block = ^{
            @strongify(self);
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                [NSThread sleepForTimeInterval:1];
//                NSLog(@"%@",weakSelf);
//            });
        };
    }
    return self;
}

@end
