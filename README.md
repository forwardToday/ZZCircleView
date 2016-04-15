
暂不支持pod下载。

使用方法
  ZZCircleView *circleView3 = [[ZZCircleView alloc] initWithFrame:CGRectMake(230, 230, 100, 100)
                                                            color:[UIColor blueColor]
                                                        lineWidth:6];
  
  [self.view addSubview:circleView3];

  ZZCircleView *circleView1 = [[ZZCircleView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)
                                                        beginColor:[UIColor redColor]
                                                       endColor:[UIColor greenColor]
                                                      lineWidth:10];

  [circleView1 setPercent:0.8];
  [self.view addSubview:circleView1];
