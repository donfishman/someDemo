//
//  ViewController.m
//  UsingOfCoredata
//
//  Created by 苹果电脑 on 16/9/13.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    NSManagedObjectContext *_context;
}
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取上下文对象
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    _context = [delegate managedObjectContext];
    
}

- (IBAction)save:(id)sender {
    
    //创建实体对象
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:_context];
    //设置属性
    [student setValue:@([_idTextField.text integerValue]) forKey:@"id"];
    [student setValue:_nameTextField.text forKey:@"name"];
    [student setValue:@([_ageTextField.text intValue]) forKey:@"age"];
    //必须通过上下文要保存
    BOOL isSave = [_context save:nil];
    NSLog(@"%@", isSave?@"保存成功":@"保存失败");
    
}

- (IBAction)quary:(id)sender {
   NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Student"];
   NSArray *requestArray = [_context executeFetchRequest:fetchRequest error:nil];
    [requestArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"id:%ld",[[obj valueForKey:@"id"]integerValue]);
        NSLog(@"name:%@",[obj valueForKey:@"name"]);
        NSLog(@"age:%d",[[obj valueForKey:@"age"]intValue]);
    }];
}
-(NSArray *)executeFetch{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Student"];
    NSArray *requestArray = [_context executeFetchRequest:fetchRequest error:nil];
    [requestArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"id:%ld",[[obj valueForKey:@"id"]integerValue]);
        NSLog(@"name:%@",[obj valueForKey:@"name"]);
        NSLog(@"age:%d",[[obj valueForKey:@"age"]intValue]);
    }];
    return requestArray;

}
- (IBAction)update:(id)sender {
    [self executeFetch];
    NSArray *fetchResult = [self executeFetch];
    __weak ViewController *weakSelf = self;
    [fetchResult enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([[obj valueForKey:@"id"]integerValue]==[weakSelf.idTextField.text integerValue]) {
            [obj setValue:weakSelf.nameTextField.text forKey:@"name"];
            [obj setValue:@([weakSelf.ageTextField.text intValue] ) forKey:@"age"];
            
        }
    }];

}

- (IBAction)delete:(id)sender {
    
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

