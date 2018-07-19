//
//  newView.m
//  ARKitStudy
//
//  Created by 唐仁于 on 2018/7/12.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "newView.h"

@implementation newView


-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddArc(path , nil, 130, 150, 25, 0, 360, 0);
    
    CGContextAddPath(ctx, path);
    
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1.0].CGColor);
    
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    
    CGContextSetLineWidth(ctx, 1.f);
    
    CGContextDrawPath(ctx, kCGPathStroke);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
