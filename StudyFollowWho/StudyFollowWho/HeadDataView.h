//
//  HeadDataView.h
//  StudyFollowWho
//
//  Created by 唐仁于 on 2018/6/19.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadViewDelegate <NSObject>

-(void)nextMonthDate;
-(void)lastMonthDate;
-(void)setPointViewWithStr:(NSString *)str;

@end

@interface HeadDataView : UIView

@property(nonatomic,weak)id<HeadViewDelegate>delegate;

//@property(nonatomic,strong)HeadDataView *headDataView;
@property(nonatomic,strong)NSMutableArray *dateArray;
@property(nonatomic,strong)UICollectionView *DataView;

@property(nonatomic,strong)UIView *PointView;




-(id)init_headViewWithFream:(CGRect)fream;

-(void)creatHeadCollectionView;

-(void)changePointViewPositionWithStr:(NSString *)str;
@end
