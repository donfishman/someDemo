//
//  TRYmainTopView.h
//  inke-live
//
//  Created by 唐仁于 on 2018/2/15.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^mainTopBlock)(NSInteger tag);
@interface TRYmainTopView : UIView

-(instancetype)initWithFrame:(CGRect)frame titleName:(NSArray *)titles;

@property (nonatomic,copy)mainTopBlock block;

-(void)scrolling:(NSInteger)tag;

@end
