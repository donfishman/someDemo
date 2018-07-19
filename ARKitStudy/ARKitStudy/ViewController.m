//
//  ViewController.m
//  ARKitStudy
//
//  Created by 唐仁于 on 2018/7/12.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "ViewController.h"
#import "newView.h"

@interface ViewController ()

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    newView *view = [[newView alloc]init];
    view.frame = self.view.frame;
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
   // [self useCAShapeLayer];
    
   // [self useCoreGraphics];
   
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)useCoreGraphics
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddArc(path , nil, 130, 150, 25, 0, 360, 0);
    
    CGContextAddPath(ctx, path);
    
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    
    CGContextSetLineWidth(ctx, 1.f);
    
    CGContextDrawPath(ctx, kCGPathStroke);
}



-(void)useCAShapeLayer
{
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    [path addArcWithCenter:CGPointMake(130, 150) radius:25 startAngle:0 endAngle:360 clockwise:YES];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.path = path.CGPath;
    
    shapeLayer.lineWidth = 1.f;
    
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    
    shapeLayer.fillColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0].CGColor;
    
    [self.view.layer addSublayer:shapeLayer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
