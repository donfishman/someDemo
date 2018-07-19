//
//  DataViewController.h
//  HandBook
//
//  Created by 唐仁于 on 2018/5/2.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;
@property (strong, nonatomic)  UIView *BassView;

@end

