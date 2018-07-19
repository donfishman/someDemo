//
//  TRYTabBarViewController.m
//  inke-live
//
//  Created by 唐仁于 on 2018/2/3.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "TRYTabBarViewController.h"
#import "TRYTabBar.h"
#import "TRYBassNavViewController.h"
#import "TRYLaunchViewController.h"


@interface TRYTabBarViewController ()<TRYTabBarDelegate>

@property (nonatomic,strong)TRYTabBar * tryTabbar;

@end

@implementation TRYTabBarViewController

-(TRYTabBar *)tryTabbar{
    
    if (!_tryTabbar) {
        _tryTabbar = [[TRYTabBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _tryTabbar.delegate = self;
    }
    return _tryTabbar;
}

-(void)tabbar:(TRYTabBar *)tabbar clickButton:(NSInteger) idx{
    if (idx != TRYItemTypeLaunch) {
        self.selectedIndex = idx - TRYItemTypeLive;
        return;
    }
    
    TRYLaunchViewController *launchVC = [[TRYLaunchViewController alloc]init];
    [self presentViewController:launchVC animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载控制器
    [self configViewControllers];
    //加载tabbar
    [self.tabBar addSubview:self.tryTabbar];
    //去除tabbar上阴影（不懂！！！）
#warning 不懂
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
}
-(void)configViewControllers{
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"TRYMainViewController",@"TRYMeViewController"]];
    
    for (NSInteger i =0; i<array.count; i++) {
        
        NSString *vcName = array[i];
        
        UIViewController *vc = [[NSClassFromString(vcName) alloc]init];
        
        TRYBassNavViewController *nav = [[TRYBassNavViewController alloc]initWithRootViewController:vc];
        
        [array replaceObjectAtIndex:i withObject:nav];
        
    }
    
    self.viewControllers = array;
    
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
