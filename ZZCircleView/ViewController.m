//
//  ViewController.m
//  ZZCircleView
//
//  Created by jerry on 16/4/15.
//  Copyright © 2016年 bobokeji. All rights reserved.
//

#import "ViewController.h"
#import "ZZCircleView.h"
#define RGB_HEX(rgb) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0]
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZZCircleView *circleView1 = [[ZZCircleView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)
                                                        beginColor:RGB_HEX(0XFB5A5F)
                                                          endColor:RGB_HEX(0XFFFFFF)
                                                         lineWidth:10];
    [self.view addSubview:circleView1];
//    [self beginCircleRefreshingWith:circleView1];
    
    ZZCircleView *circleView2 = [[ZZCircleView alloc] initWithFrame:CGRectMake(100, 230, 100, 100)
                                                        beginColor:RGB_HEX(0XFFFFF)
                                                          endColor:RGB_HEX(0XFFF)
                                                         lineWidth:8];
    [circleView2 setPercent:0.8];
    [self.view addSubview:circleView2];
    [self beginCircleRefreshingWith:circleView2];
    
    ZZCircleView *circleView3 = [[ZZCircleView alloc] initWithFrame:CGRectMake(230, 230, 100, 100)
                                                              color:[UIColor blueColor]
                                                          lineWidth:6];
    [self.view addSubview:circleView3];
    [circleView3 setPercent:0.5];
//    [self beginCircleRefreshingWith:circleView3];
}

- (void)beginCircleRefreshingWith:(ZZCircleView *)circleView
{
    CABasicAnimation *circleAni = [CABasicAnimation animation];
    circleAni.keyPath = @"transform.rotation.z";
    circleAni.duration = 0.8;
    circleAni.fromValue = @(0);
    circleAni.toValue = @(2*M_PI);
    circleAni.repeatCount = INFINITY;
    [circleView.layer addAnimation:circleAni forKey:@"circleAni"];
}

@end
