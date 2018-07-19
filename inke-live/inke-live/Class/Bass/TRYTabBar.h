//
//  TRYTabBar.h
//  inke-live
//
//  Created by 唐仁于 on 2018/2/3.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TRYTabBar;

//创建tabbar上按钮的枚举
typedef NS_ENUM(NSUInteger,TRYItemType) {
    TRYItemTypeLaunch = 10,
    TRYItemTypeLive = 100, //展示直播
    TRYItemTypeMine,       //我的

};

//创建block
typedef void(^TabBlock)(TRYTabBar *tabbar,TRYItemType idx);

//创建协议
@protocol TRYTabBarDelegate <NSObject>

//协议里采用的方法
-(void)tabbar:(TRYTabBar *)tabbar clickButton:(NSInteger) idx;
@end

@interface TRYTabBar : UIView
//协议属性用weak修饰
@property(nonatomic,weak) id<TRYTabBarDelegate> delegate;
//block属性用copy修饰
@property(nonatomic,copy) TabBlock block;
@end





