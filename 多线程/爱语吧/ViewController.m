//
//  ViewController.m
//  爱语吧
//
//  Created by 唐仁于 on 2018/3/9.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "ViewController.h"
#import "dispatchViewController.h"


static NSInteger count = 100;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    
    [thread1 start];
    
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(sellTicket) object:nil];
    
    [thread2 start];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)sellTicket{
    
    
    while (1) {
        
        @synchronized (self) {
            
            [NSThread sleepForTimeInterval:0.2];
            if (count != 0) {
                count--;
                NSLog(@"已售%ld,%@",(long)count,[NSThread currentThread]);
            }else{
                
                NSLog(@"票已卖光");
                break;
            }
        }
    }
    dispatchViewController *viewController = [[dispatchViewController alloc]init];
    [self presentViewController:viewController animated:YES completion:nil];
}

-(void)threadTest1{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(handleThread) object:nil];
    thread.threadPriority = 0.1;
    thread.name = @"线程1";
    [thread start];
    
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(handleThread) object:nil];
    thread2.name = @"线程2";
    thread2.threadPriority = 1;
    [thread2 start];
    
}

-(void)threadTest3{
    
    [self performSelector:@selector(handleThread) withObject:nil afterDelay:1];
    //隐式创建多线程
    [self performSelectorInBackground:@selector(handleThread) withObject:nil];
    
}

-(void)threadTest2{
    
    [NSThread detachNewThreadSelector:@selector(handleThread) toTarget:self withObject:nil];
}

-(void)threadTest4{
    [self performSelector:@selector(handleThread) withObject:nil afterDelay:1];
    [self performSelectorInBackground:@selector(handleThread) withObject:nil];
    
}
-(void)handleThread{
    
    NSLog(@"%@",[NSThread currentThread]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
