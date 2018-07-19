//
//  PanoVC.m
//  vrdemo
//
//  Created by 山楂树 on 2018/3/12.
//  Copyright © 2018年 山楂树. All rights reserved.
//

#import "PanoVC.h"
#import "PanoramaView.h"

@interface PanoVC(){
    PanoramaView *panoramaView;
}

@end

@implementation PanoVC

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    panoramaView = [[PanoramaView alloc] initWithFrame:self.hbFrame];
    [panoramaView setImageWithName:@"park_2048.jpg"];
    [panoramaView setOrientToDevice:YES];
    [panoramaView setTouchToPan:YES];
    [panoramaView setPinchToZoom:NO];
    [panoramaView setShowTouches:NO];
    [panoramaView setVRMode:NO];
    [self setView:panoramaView];
    
}

-(void) glkView:(GLKView *)view drawInRect:(CGRect)rect{
    [panoramaView draw];
}



@end
