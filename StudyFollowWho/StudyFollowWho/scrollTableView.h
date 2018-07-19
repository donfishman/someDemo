//
//  scrollTableView.h
//  StudyFollowWho
//
//  Created by 唐仁于 on 2018/7/2.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollDelegete <NSObject>

-(void)changePointViewPositionWithStr:(NSString *)str;

@end

@interface scrollTableView : UIView<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *DateArray;

@property(nonatomic,weak)id<ScrollDelegete>delegete;

-(void)addTableView;

-(id)initWithFrame:(CGRect)frame;

-(void)scrollToRowWithRow:(NSInteger)Row;





@end
