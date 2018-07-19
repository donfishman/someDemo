//
//  AppDelegate.h
//  UsingOfCoredata
//
//  Created by 苹果电脑 on 16/9/13.
//  Copyright © 2016年 wyzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//上下文对象，用来操作实体
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//数据模型，读取所有的实体信息
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//添加持久化数据库(实现中默认添加了一个Sqlite数据库)
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

