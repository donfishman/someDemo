//
//  TRYMainViewController.m
//  inke-live
//
//  Created by 唐仁于 on 2018/2/4.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "TRYMainViewController.h"
#import "TRYmainTopView.h"
@interface TRYMainViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic,strong) NSArray *nameList;
@property (nonatomic,strong) TRYmainTopView * topView;

@end

@implementation TRYMainViewController

-(TRYmainTopView *)topView{
    
    if (!_topView) {
        _topView = [[TRYmainTopView alloc] initWithFrame:CGRectMake(0, 0, 200, 50) titleName:self.nameList];
        
        __weak typeof(self)weakSelf = self;
        _topView.block = ^(NSInteger tag){
            
            CGPoint point = CGPointMake(tag * SCREEN_WIDTH, weakSelf.contentScrollView.contentOffset.y);
            
           [weakSelf.contentScrollView  setContentOffset:point animated:YES];
            
        };
    }
    return _topView;
}

-(NSArray *)nameList{
    
    if (!_nameList) {
        _nameList = @[@"关注",@"热门",@"附近"];
    }
    return _nameList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)initUI{
    //添加nav上左右按钮
    [self setupNav];
    //添加主控制器上scrollView上的三个子视图控制器
    [self setupChildViewControllers];

    
}
- (void)setupNav{
    
    self.navigationItem.titleView = self.topView;   
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"global_search"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"title_button_more"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
}


- (void)setupChildViewControllers{
    
    NSArray *vcNames = @[@"TRYFocusViewController",@"TRYHotViewController",@"TRYNearViewController"];
    
    for (int i = 0; i<vcNames.count; i++) {
        
        NSString *vcName = vcNames[i];
        
        UIViewController * VC = [[NSClassFromString(vcName) alloc] init];
        
        VC.title = self.nameList[i];
        //当执行addChildViewController时，不会执行viewdidload方法，内存占用小
        [self addChildViewController:VC];
        
    }
    
    //将子控制器的view，添加到mainVC的scrollView上
    
    //设置scrollView的contentSize
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.nameList.count, 0);
    
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    [self scrollViewDidEndDecelerating:self.contentScrollView];
    
    
}
//动画结束的代理
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    CGFloat width = SCREEN_WIDTH;
//    CGFloat height = SCREEN_HEIGHT;
    CGFloat offset = scrollView.contentOffset.x;
    
    //获取索引值
    NSInteger idx = offset / width;
    
    //实现滑动过程中button的联动
    [self.topView scrolling:idx];
    
    //根据索引值返回相应的vc
    UIViewController * vc = self.childViewControllers[idx];
    
    //判断当前vc是否执行过viewdidload
    if ([vc isViewLoaded]) return;
    //设置子控制器的View大小
    vc.view.frame = CGRectMake(offset, 0, scrollView.frame.size.width, scrollView.frame.size.height);
    //将自控制器的View加载到scrollView上
    [scrollView addSubview:vc.view];
    
}
//减速结束后加载子控制器(代理方法)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
