//
//  HBTableViewController.m
//  vrdemo
//
//  Created by 山楂树 on 2018/3/12.
//  Copyright © 2018年 山楂树. All rights reserved.
//

#import "HBTableViewController.h"
#import "PanoVC.h"

@interface HBTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) NSArray *dataArray;

@property (nonatomic ,strong) PanoVC *panoVC;

@property (nonatomic ,strong) NSIndexPath *currentPanoIndex;

@property (nonatomic ,strong) UIImageView *global360;

@end

@implementation HBTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self addChildVC];
    [self scrollViewDidScroll:self.tableView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)addChildVC{
    self.panoVC = [PanoVC new];
    self.panoVC.hbFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250);
    [self addChildViewController:self.panoVC];
    [self.panoVC didMoveToParentViewController:self];
}


-(NSArray *)dataArray{
    if(_dataArray == nil){
        _dataArray = @[@(1),@(1),@(1),@(1),@(0),@(1),@(1),@(1),@(1),@(1),@(1),@(1)];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.dataArray[indexPath.row] integerValue] == 0){
        return 250;
    }
    return 150;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.dataArray[indexPath.row] integerValue] == 0){
        if(self.panoVC.view.superview){
            [self.panoVC.view removeFromSuperview];
        }
        [cell addSubview:self.panoVC.view];
        self.currentPanoIndex = indexPath;
    }else{
        if(self.panoVC.view.superview == cell){
            [self.panoVC.view removeFromSuperview];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGRect cellFrame = [self.tableView rectForRowAtIndexPath:self.currentPanoIndex];
    if(scrollView.contentOffset.y + scrollView.frame.size.height > cellFrame.size.height + cellFrame.origin.y && scrollView.contentOffset.y < cellFrame.origin.y){
        self.panoVC.paused = NO;
        if(self.global360.superview){
            [self.global360 removeFromSuperview];
        }
    }else{
        self.panoVC.paused = YES;
        if(!self.global360.superview){
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.currentPanoIndex];
            self.global360.center = CGPointMake(cellFrame.size.width/2.0, cellFrame.size.height/2.0);
            [cell addSubview:self.global360];
        }
    }
}

- (UIImageView *)global360{
    if(_global360 == nil){
        _global360 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        _global360.contentMode = UIViewContentModeScaleAspectFit;
        _global360.image = [UIImage imageNamed:@"global"];
    }
    return _global360;
}

@end
