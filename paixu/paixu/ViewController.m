//
//  ViewController.m
//  paixu
//
//  Created by 唐仁于 on 2018/6/27.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)NSMutableArray *array;
@property(nonatomic,strong)UITextField *text1;
@property(nonatomic,strong)UITextField *text2;

@property(nonatomic,strong)UITextField *text3;

@property(nonatomic,strong)UITextField *text4;
@property(nonatomic,strong)UITextField *text5;



@end

@implementation ViewController
-(NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.text1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 20, 50, 20)];
    self.text1.backgroundColor = [UIColor redColor];
    self.text2 = [[UITextField alloc]initWithFrame:CGRectMake(70, 20, 50, 20)];
    self.text2.backgroundColor = [UIColor redColor];
    self.text3 = [[UITextField alloc]initWithFrame:CGRectMake(130, 20, 50, 20)];
    self.text3.backgroundColor = [UIColor redColor];

    self.text4 = [[UITextField alloc]initWithFrame:CGRectMake(190, 20, 50, 20)];
    self.text4.backgroundColor = [UIColor redColor];

    self.text5 = [[UITextField alloc]initWithFrame:CGRectMake(250, 20, 50, 20)];
    self.text5.backgroundColor = [UIColor redColor];

    [self.view addSubview:self.text1];
    [self.view addSubview:self.text2];
    [self.view addSubview:self.text3];
    [self.view addSubview:self.text4];
    [self.view addSubview:self.text5];

    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 50)];
    [btn setTitle:@"排序" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)btnClick
{
    NSString *str1 = self.text1.text;
    
    NSString *str2 = self.text2.text;
    
    NSString *str3 = self.text3.text;
    
    NSString *str4 = self.text4.text;
    
    NSString *str5 = self.text5.text;
    

    NSArray *arr = @[str1,str2,str3,str4,str5];
    
    [self.array addObjectsFromArray:arr];
    
    
    for (int i = 0; i<self.array.count-1; i++) {
        for (int j = 0; j<self.array.count-1-i; j++) {
            if ([self.array[j] integerValue]>[self.array[j+1] integerValue]) {
                NSString *string = self.array[j];
                self.array[j] = self.array[j+1];
                self.array[j+1] = string;
            }
        }
    }
    
    NSLog(@"array=%@",self.array);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
