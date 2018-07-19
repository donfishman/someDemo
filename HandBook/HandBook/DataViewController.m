//
//  DataViewController.m
//  HandBook
//
//  Created by 唐仁于 on 2018/5/2.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "DataViewController.h"
#import "Masonry.h"
@interface DataViewController ()

@property (nonatomic,strong)NSMutableArray *ImageArray;
@property (nonatomic,strong)UIImageView *gestureImageView;

@end

@implementation DataViewController

-(NSMutableArray *)ImageArray
{
    if (!_ImageArray) {
        _ImageArray = [NSMutableArray array];
    }
    return _ImageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    imageview.image = [UIImage imageNamed:@"1"];
//    [self.BassView addSubview:imageview];
    [self creatBassView];

    [self creatScrollView];
    
    
    
    

    // Do any additional setup after loading the view, typically from a nib.
}


-(void)creatBassView
{
    self.BassView = [[UIView alloc]initWithFrame:CGRectMake(self.dataLabel.frame.origin.x, self.dataLabel.frame.origin.y + self.dataLabel.bounds.size.height + 20, self.dataLabel.frame.size.width, [UIScreen mainScreen].bounds.size.height - self.dataLabel.frame.origin.y - self.dataLabel.bounds.size.height - 20)];
    
    self.BassView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.BassView];
    
    __weak typeof(self)weakSelf = self;
    [self.BassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.dataLabel.mas_bottom);
        make.left.equalTo(weakSelf.dataLabel);
        make.right.equalTo(weakSelf.dataLabel);
        make.bottom.equalTo(weakSelf.view).offset(-20);
    }];
}

-(void)creatScrollView
{
    UIScrollView *buttomView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 45 - 20 - 80, [UIScreen mainScreen].bounds.size.width - 40, 80)];
    buttomView.contentSize = CGSizeMake(80 * 20, 0);
    buttomView.backgroundColor = [UIColor orangeColor];
    [self.BassView addSubview:buttomView];
    
    for (int i = 0; i < 20; i++) {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i*80, 0, 80, 80)];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]] forState:UIControlStateNormal];
        btn.tag = i;
        [buttomView addSubview:btn];
        [btn addTarget:self action:@selector(addImageWithBtnTag:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)addImageWithBtnTag:(UIButton *)btn
{
    UIImageView *addImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.BassView.frame.size.width/2 - 50, 150, 100, 100)];
    addImage.userInteractionEnabled = YES;
    addImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",(long)btn.tag]];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRecognizer:)];
    [addImage addGestureRecognizer:pan];
    
    [self.BassView addSubview:addImage];
    [self.ImageArray addObject:addImage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)panGestureRecognizer:(UIPanGestureRecognizer *)panGesture
{
    CGPoint point = [panGesture translationInView:panGesture.view];
    
    panGesture.view.center = CGPointMake(panGesture.view.center.x + point.x, panGesture.view.center.y + point.y);
    
    [panGesture setTranslation:CGPointMake(0, 0) inView:self.view];
//    [UIView animateWithDuration:0.1 animations:^{
//        panGesture.view.center = point;
//        [panGesture setTranslation:CGPointZero inView:panGesture.view.superview];
//    }];
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}


@end
