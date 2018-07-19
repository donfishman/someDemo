//
//  dispatchViewController.m
//  爱语吧
//
//  Created by 唐仁于 on 2018/3/13.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "dispatchViewController.h"

@interface dispatchViewController ()

@end

@implementation dispatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //并发队列
    dispatch_queue_t concurrent = dispatch_queue_create("com.baidu",DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 10; i++) {
        //异步请求
        dispatch_async(concurrent, ^{
            NSLog(@"%d",i);
        });
    }
    
    dispatch_queue_t s = dispatch_queue_create("com.ali", DISPATCH_QUEUE_SERIAL);
    
    for (int i = 0; i < 10; i++) {
        //异步请求
        dispatch_sync(s, ^{
            NSLog(@"I LOVE YOU");
        });
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        <#code to be executed once#>
    });
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
