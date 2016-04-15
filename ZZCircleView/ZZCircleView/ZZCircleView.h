//
//  ZZCircleView.h
//  ZZCircleView
//
//  Created by jerry on 16/4/15.
//  Copyright © 2016年 bobokeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZCircleView : UIView

/*init
 frame:frame
 colorHex: Color such as:OXFFFFFF
 lineWidth: line width
 */
- (id)initWithFrame:(CGRect)frame
              color:(UIColor *)lineColor
          lineWidth:(CGFloat)lineWidth;

/*init
 frame:frame
 beginColor: begin color
 endColor: end color
 lineWidth: line width
 */
- (id)initWithFrame:(CGRect)frame
         beginColor:(UIColor *)beginColor
           endColor:(UIColor *)endColor
          lineWidth:(CGFloat)lineWidth;

/*set circle line percent*/
- (void)setPercent:(CGFloat)percent;

@end