//
//  ViewController.m
//  vrdemo
//
//  Created by 山楂树 on 2018/3/12.
//  Copyright © 2018年 山楂树. All rights reserved.
//

#import "ViewController.h"
#import "HBTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"展示表格" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 100);
    button.center = self.view.center;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)btnAction:(UIButton *)btn{
    HBTableViewController *vc = [HBTableViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
