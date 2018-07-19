//
//  TRYmainTopView.m
//  inke-live
//
//  Created by 唐仁于 on 2018/2/15.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "TRYmainTopView.h"

@interface TRYmainTopView ()

@property (nonatomic,strong) UIView * lineView;
@property (nonatomic,strong) NSMutableArray *buttons;

@end

@implementation TRYmainTopView

-(NSMutableArray *)buttons{
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
    
}


- (instancetype)initWithFrame:(CGRect)frame titleName:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat btnW = self.width / titles.count;
        CGFloat btnH = self.height;
        
        for (NSInteger i = 0; i < titles.count; i++) {
            UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString * vcName = titles[i];
            //设置按钮文字
            [titleBtn setTitle:vcName forState:UIControlStateNormal];
            //设置按钮颜色
            [titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            //设置字体
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
            
            titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            
            titleBtn.tag = i;
            
            [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:titleBtn];
            
            [self.buttons addObject:titleBtn];
            
            if (i == 1) {
                
                CGFloat h = 2;
                
                CGFloat y = 40;
                
                [titleBtn.titleLabel sizeToFit];
                
                self.lineView = [[UIView alloc]init];
                
                self.lineView.backgroundColor = [UIColor whiteColor];
                self.lineView.height = h;
                self.lineView.width = titleBtn.titleLabel.width;
                self.lineView.top = y;
                self.lineView.centerX = titleBtn.centerX;
                [self addSubview:self.lineView];
                
            }
            
            
        }
        
    }
    return self;
}

-(void)titleClick:(UIButton *)button {
    
    if (self.block) {
        self.block(button.tag);
    }
    
    [self scrolling:button.tag];
    
}

-(void)scrolling:(NSInteger)tag{
    
    UIButton * button = self.buttons[tag];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.lineView.centerX = button.centerX;
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
