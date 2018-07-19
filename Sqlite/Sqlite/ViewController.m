//
//  ViewController.m
//  Sqlite
//
//  Created by 唐仁于 on 2018/7/4.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "ViewController.h"
#import "NSString+CachePath.h"
#import <sqlite3.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *AddBtn;
@property (weak, nonatomic) IBOutlet UIButton *DelBtn;
@property (weak, nonatomic) IBOutlet UIButton *ChangeBtn;
@property (weak, nonatomic) IBOutlet UIButton *FindBtn;

@property(nonatomic,copy)NSString *fileName;

@end

static sqlite3 * dataBase = nil;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fileName = [NSString cachePathWithFileName:@"newSqlite.sqlite"];
    NSLog(@"%@",self.fileName);
    
    if (sqlite3_open(self.fileName.UTF8String, &dataBase) == SQLITE_OK) {
        
        NSString *str = @"create table if not exists t_student (id integer primary key autoincrement, name text, age integer);";
        
        char *error;
        sqlite3_exec(dataBase, str.UTF8String, NULL, NULL, &error);
        if (error) {
            NSLog(@"创建表失败%s",error);
        }else{
            NSLog(@"创建表成功");
        }
        
    }else{
        NSLog(@"数据库打开失败");

    }
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)AddAction:(id)sender {
    NSString * arm = [NSString stringWithFormat:@"try%02d",arc4random_uniform(100)];
    
    if (sqlite3_open(self.fileName.UTF8String, &dataBase)==SQLITE_OK) {
        NSString *sql = [NSString stringWithFormat:@"insert into t_student (name, age) values ('%@', %u)",arm,arc4random_uniform(100)];
        
        char *error;
        sqlite3_exec(dataBase, sql.UTF8String, NULL, NULL, &error);
        if (error) {
            NSLog(@"增加失败%s",error);
        }else{
            NSLog(@"增加成功");
        }
        sqlite3_close(dataBase);
    }
    
}
- (IBAction)delegateAction:(id)sender {
    if (sqlite3_open(self.fileName.UTF8String, &dataBase)==SQLITE_OK) {
        NSString *sql = [NSString stringWithFormat:@"delete from t_student where name = '%@';",@"haha"];
        
        char *error;
        sqlite3_exec(dataBase, sql.UTF8String, NULL, NULL, &error);
        if (error) {
            NSLog(@"删除失败%s",error);
        }else{
            NSLog(@"删除成功");
        }
        sqlite3_close(dataBase);
    }
    
}
- (IBAction)changeAction:(id)sender {
    if (sqlite3_open(self.fileName.UTF8String, &dataBase)==SQLITE_OK) {
        NSString *sql = @"update t_student set age = 25 where name = 'try'";
        char *error;
        sqlite3_exec(dataBase, sql.UTF8String, NULL, NULL, &error);
        if (error) {
            NSLog(@"更新失败");
        }else{
            NSLog(@"更新成功");
        }
        
    }else{
        NSLog(@"打开失败");
    }
    
}
- (IBAction)findAction:(id)sender {
    
    NSString *sql = @"select * from t_student order by age desc";
    
    sqlite3_stmt *stmt;
    if (sqlite3_prepare(dataBase, sql.UTF8String, -1, &stmt, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char * text = sqlite3_column_text(stmt, 1);
            NSString *name = [NSString stringWithFormat:@"%s",text];
            
          //  NSString *str1 = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            
            NSInteger age = sqlite3_column_int(stmt, 2);
            
            NSLog(@"name==%@,age==%ld",name,age);
            
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
