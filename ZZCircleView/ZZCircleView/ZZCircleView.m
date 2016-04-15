//
//  ZZCircleView.m
//  ZZCircleView
//
//  Created by jerry on 16/4/15.
//  Copyright © 2016年 bobokeji. All rights reserved.
//

#import "ZZCircleView.h"

static const CGFloat kLineWidth = 2.f;

@interface ZZCircleView ()
@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property (strong, nonatomic) CAGradientLayer *colorLayerTopRight;
@property (strong, nonatomic) CAGradientLayer *colorLayerDownRight;
@property (strong, nonatomic) CAGradientLayer *colorLayerDownLeft;
@property (strong, nonatomic) CAGradientLayer *colorLayerTopLeft;
@property (strong, nonatomic) CALayer *gradientLayer;
@property (strong, nonatomic) UIColor *beginColor;
@property (strong, nonatomic) UIColor *endColor;
@property (strong, nonatomic) UIColor *leftColor;
@property (strong, nonatomic) UIColor *topColor;
@property (strong, nonatomic) UIColor *rightColor;
@property (strong, nonatomic) UIColor *downColor;
@property (assign, nonatomic) CGFloat lineWidth;

@end

@implementation ZZCircleView

#pragma mark - init

- (id)initWithFrame:(CGRect)frame
              color:(UIColor *)lineColor
          lineWidth:(CGFloat)lineWidth
{
    return [self initWithFrame:frame
                    beginColor:lineColor
                      endColor:lineColor
                     lineWidth:lineWidth];
}

- (id)initWithFrame:(CGRect)frame
         beginColor:(UIColor *)beginColor
           endColor:(UIColor *)endColor
          lineWidth:(CGFloat)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth  = lineWidth;
        _beginColor = beginColor;
        _endColor   = endColor;
        [self configSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews
{
    [self calculateColor];
    if (self.lineWidth < 0.1) {
        self.lineWidth = kLineWidth;
    }
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = self.bounds;
    self.shapeLayer.lineWidth = self.lineWidth;
//    self.shapeLayer.lineCap = kCALineCapRound;
    self.shapeLayer.strokeColor = self.beginColor.CGColor;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:self.shapeLayer];
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2)
                                                              radius:CGRectGetWidth(self.frame) / 2 - self.lineWidth / 2
                                                          startAngle:-M_PI_2
                                                            endAngle:M_PI * 2 - M_PI_2
                                                           clockwise:YES];
    self.shapeLayer.path = circlePath.CGPath;
    
    
    CALayer *gradientLayer  = [CALayer layer];
    self.gradientLayer      = gradientLayer;
    
    CAGradientLayer *colorLayerTopLeft = [CAGradientLayer layer];
    colorLayerTopLeft.frame   = CGRectMake(0, 0,
                                           CGRectGetWidth(self.frame) / 2,
                                           CGRectGetHeight(self.frame) / 2);
    colorLayerTopLeft.colors  = @[(__bridge id)self.leftColor.CGColor,
                                  (__bridge id)self.topColor.CGColor];
    colorLayerTopLeft.startPoint = CGPointMake(0, 1);
    colorLayerTopLeft.endPoint   = CGPointMake(1, 0);
    [gradientLayer addSublayer:colorLayerTopLeft];
    self.colorLayerTopLeft = colorLayerTopLeft;
    
    CAGradientLayer *colorLayerTopRight = [CAGradientLayer layer];
    colorLayerTopRight.frame    = CGRectMake(CGRectGetWidth(self.frame) / 2,
                                             0,
                                             CGRectGetWidth(self.frame) / 2,
                                             CGRectGetHeight(self.frame) / 2);
    colorLayerTopRight.colors   = @[(__bridge id)self.beginColor.CGColor,
                                    (__bridge id)self.rightColor.CGColor];
    colorLayerTopRight.startPoint   = CGPointMake(0, 0);
    colorLayerTopRight.endPoint     = CGPointMake(1, 1);
    [gradientLayer addSublayer:colorLayerTopRight];
    self.colorLayerTopRight = colorLayerTopRight;
    
    CAGradientLayer *colorLayerDownLeft = [CAGradientLayer layer];
    colorLayerDownLeft.frame    = CGRectMake(0,
                                             CGRectGetHeight(self.frame) / 2,
                                             CGRectGetWidth(self.frame) / 2,
                                             CGRectGetHeight(self.frame) / 2);
    colorLayerDownLeft.colors   = @[(__bridge id)self.downColor.CGColor,
                                    (__bridge id)self.leftColor.CGColor];
    colorLayerDownLeft.startPoint   = CGPointMake(1, 1);
    colorLayerDownLeft.endPoint     = CGPointMake(0, 0);
    [gradientLayer addSublayer:colorLayerDownLeft];
    self.colorLayerDownLeft = colorLayerDownLeft;
    
    CAGradientLayer *colorLayerDownRight = [CAGradientLayer layer];
    colorLayerDownRight.frame    = CGRectMake(CGRectGetWidth(self.frame) / 2,
                                              CGRectGetHeight(self.frame) / 2,
                                              CGRectGetWidth(self.frame) / 2,
                                              CGRectGetHeight(self.frame) / 2);
    colorLayerDownRight.colors   = @[(__bridge id)self.rightColor.CGColor,
                                     (__bridge id)self.downColor.CGColor];
    colorLayerDownRight.startPoint   = CGPointMake(1, 0);
    colorLayerDownRight.endPoint     = CGPointMake(0, 1);
    [gradientLayer addSublayer:colorLayerDownRight];
    self.colorLayerDownRight = colorLayerDownRight;
    
    
    [gradientLayer setMask:self.shapeLayer];
    [self.layer addSublayer:gradientLayer];
}

#pragma mark

- (void)setPercent:(CGFloat)percent
{
    self.shapeLayer.strokeEnd = percent;
}

- (void)calculateColor
{
    if (self.beginColor == self.endColor) {
        self.rightColor = self.beginColor;
        self.downColor  = self.beginColor;
        self.leftColor  = self.beginColor;
        self.topColor   = self.beginColor;
        return;
    }
    
    NSArray *begins = [self changeUIColorToRGB:self.beginColor];
    NSArray *ends = [self changeUIColorToRGB:self.endColor];
    CGFloat redGap = [begins[1] floatValue] / 4 - [ends[1] floatValue] / 4;
    CGFloat greenGap = [begins[2] floatValue] / 4 - [ends[2] floatValue] / 4;
    CGFloat blueGap = [begins[3] floatValue] / 4 - [ends[3] floatValue] / 4;
    CGFloat alphaGap = [begins[4] floatValue] / 4 - [ends[4] floatValue] / 4;
    
    CGFloat redBegin = [begins[1] floatValue];
    CGFloat grennBegin = [begins[2] floatValue];
    CGFloat blueBegin = [begins[3] floatValue];
    CGFloat alphaBegin = [begins[4] floatValue];
    
    self.rightColor = [UIColor colorWithRed:redBegin - redGap
                                      green:grennBegin - greenGap
                                       blue:blueBegin - blueGap
                                      alpha:alphaBegin - alphaGap];
    self.downColor = [UIColor colorWithRed:redBegin - redGap * 2
                                     green:grennBegin - greenGap * 2
                                      blue:blueBegin - blueGap * 2
                                     alpha:alphaBegin - alphaGap * 2];
    self.leftColor = [UIColor colorWithRed:redBegin - redGap * 3
                                     green:grennBegin - greenGap * 3
                                      blue:blueBegin - blueGap * 3
                                     alpha:alphaBegin - alphaGap * 3];
    self.topColor = [UIColor colorWithRed:redBegin - redGap * 4
                                    green:grennBegin - greenGap * 4
                                     blue:blueBegin - blueGap * 4
                                    alpha:alphaBegin - alphaGap * 4];
}

- (NSArray *)changeUIColorToRGB:(UIColor *)color
{
    NSString *RGBValue = [NSString stringWithFormat:@"%@",color];
    NSArray *RGBArr = [RGBValue componentsSeparatedByString:@" "];
    return RGBArr;
}

#pragma mark - private mehtods

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.shapeLayer.frame = self.bounds;
    self.colorLayerTopLeft.frame    = CGRectMake(0, 0,
                                                 CGRectGetWidth(self.frame) / 2,
                                                 CGRectGetHeight(self.frame) / 2);
    
    self.colorLayerTopRight.frame   = CGRectMake(CGRectGetWidth(self.frame) / 2,
                                                 0,
                                                 CGRectGetWidth(self.frame) / 2,
                                                 CGRectGetHeight(self.frame) / 2);
    
    self.colorLayerDownLeft.frame   = CGRectMake(0,
                                                 CGRectGetHeight(self.frame) / 2,
                                                 CGRectGetWidth(self.frame) / 2,
                                                 CGRectGetHeight(self.frame) / 2);
    
    self.colorLayerDownRight.frame  = CGRectMake(CGRectGetWidth(self.frame) / 2,
                                                 CGRectGetHeight(self.frame) / 2,
                                                 CGRectGetWidth(self.frame) / 2,
                                                 CGRectGetHeight(self.frame) / 2);
}



@end
