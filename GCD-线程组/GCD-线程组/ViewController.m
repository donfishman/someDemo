//
//  ViewController.m
//  GCD-线程组
//
//  Created by 唐仁于 on 2018/3/13.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个线程组
    dispatch_group_t group = dispatch_group_create();
    //获取一个全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_group_async(group, queue , ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"download picture one");
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"download picture two");
    });
    
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"download picture three");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"It's OK");
    });
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
