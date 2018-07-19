 //
//  TRYTabBar.m
//  inke-live
//
//  Created by 唐仁于 on 2018/2/3.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "TRYTabBar.h"
@interface TRYTabBar ()

@property (nonatomic,strong)UIImageView *tabBgView;
@property (nonatomic,strong)NSArray *datalist;
@property (nonatomic,strong)UIButton *lastItem;
@property (nonatomic,strong)UIButton *cameraBtn;
@end

@implementation TRYTabBar

-(UIButton *)cameraBtn{
    
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cameraBtn setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
//        [_cameraBtn sizeToFit];
        [_cameraBtn addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        _cameraBtn.tag = TRYItemTypeLaunch;
    }
    return _cameraBtn;
}

-(NSArray *)datalist{
    if (!_datalist) {
        _datalist = @[@"tab_live",@"tab_me"];
    }
    return _datalist;
}
-(UIImageView *)tabBgView{
    if (!_tabBgView) {
        _tabBgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _tabBgView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //加载背景
        [self addSubview:self.tabBgView];
        
        for (NSInteger i = 0; i < self.datalist.count; i++) {
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            
            //不让图片在高亮状态下改变
            item.adjustsImageWhenHighlighted = NO;
            
            [item setImage:[UIImage imageNamed:self.datalist[i]] forState:
             UIControlStateNormal];
            
            [item setImage:[UIImage imageNamed:[self.datalist[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
            
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            
            item.tag = TRYItemTypeLive + i;
            
            if (i == 0) {
                item.selected = YES;
                self.lastItem = item;
            }
            
            [self addSubview:item];
        }
        //添加直播按钮
        [self addSubview:self.cameraBtn];
        
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.tabBgView.frame = self.bounds;
    
    CGFloat width = self.bounds.size.width/self.datalist.count;
    
    for (int i = 0; i<[self subviews].count; i++) {
        UIView *view = [self subviews][i];
        if ([view isKindOfClass:[UIButton class]]) {
            view.frame = CGRectMake((view.tag - TRYItemTypeLive)*width, 0, width, self.frame.size.height);
        }
    }
    //设置直播按钮的位置（center）
    [self.cameraBtn sizeToFit];
    self.cameraBtn.center = CGPointMake(self.center.x, self.bounds.size.height - 50);
    
}
//button的点击事件
-(void)clickItem:(UIButton *)button{
    //代理
    if ([self.delegate respondsToSelector:@selector(tabbar:clickButton:)]) {
        [self.delegate tabbar:self clickButton:button.tag];
    }
    //block
    if (self.block) {
        self.block(self, button.tag);
    }
//    !self.block?:self.block(self,button.tag);
    
    if (button.tag == TRYItemTypeLaunch) {
        return;
    }
    self.lastItem.selected = NO;
    button.selected = YES;
    self.lastItem = button;
    
    //设置动画
    [UIView animateWithDuration:0.2 animations:^{
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            button.transform = CGAffineTransformIdentity;
        }];
    }];
}



@end
