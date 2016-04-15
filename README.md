# ZZCircleView
暂不支持pod下载。
使用方法
#define RGB_HEX(rgb) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0]
  ZZCircleView *circleView3 = [[ZZCircleView alloc] initWithFrame:CGRectMake(230, 230, 100, 100)
                                                              color:[UIColor blueColor]
                                                          lineWidth:6];
  [self.view addSubview:circleView3];
    
  ZZCircleView *circleView1 = [[ZZCircleView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)
                                                        beginColor:RGB_HEX(0XFB5A5F)
                                                          endColor:RGB_HEX(0XFFFFFF)
                                                         lineWidth:10];
    [self.view addSubview:circleView1];
    
