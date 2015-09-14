//
//  HashMarks.m
//  Dally_lab3
//
//  Created by Labuser on 2/23/15.
//  Copyright (c) 2015 wustl. All rights reserved.
//

#import "HashMarks.h"
#include <stdlib.h>

@implementation HashMarks

- (void)drawRect:(CGRect)rect {
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] setFill];
    [[UIColor blackColor] setStroke];
    
    int thickness = 5;
    int deviation = 3;
    
    //left
    CGFloat startx = width/3;
    CGFloat endx = width/3;
    CGFloat starty = 0;
    CGFloat endy = height;
    CGContextBeginPath (context);
    CGContextMoveToPoint    (context, startx-thickness+arc4random_uniform(deviation), starty+arc4random_uniform(2*deviation));
    CGContextAddLineToPoint (context, startx+thickness-arc4random_uniform(deviation), starty+arc4random_uniform(2*deviation));
    CGContextAddLineToPoint (context, endx+thickness-arc4random_uniform(deviation), endy-arc4random_uniform(2*deviation));
    CGContextAddLineToPoint (context, endx-thickness+arc4random_uniform(deviation), endy-arc4random_uniform(2*deviation));
    CGContextClosePath (context);
    CGContextDrawPath (context,	kCGPathFillStroke);
    
    //right
    startx = 2*width/3;
    endx = 2*width/3;
    starty = 0;
    endy = height;
    CGContextBeginPath (context);
    CGContextMoveToPoint    (context, startx-thickness+arc4random_uniform(deviation), starty+arc4random_uniform(2*deviation));
    CGContextAddLineToPoint (context, startx+thickness-arc4random_uniform(deviation), starty+arc4random_uniform(2*deviation));
    CGContextAddLineToPoint (context, endx+thickness-arc4random_uniform(deviation), endy-arc4random_uniform(2*deviation));
    CGContextAddLineToPoint (context, endx-thickness+arc4random_uniform(deviation), endy-arc4random_uniform(2*deviation));
    CGContextClosePath (context);
    CGContextDrawPath (context,	kCGPathFillStroke);
    
    //top
    startx = 0;
    endx = width;
    starty = height/3;
    endy = height/3;
    CGContextBeginPath (context);
    CGContextMoveToPoint    (context, startx+arc4random_uniform(2*deviation), starty-thickness+arc4random_uniform(2*deviation));
    CGContextAddLineToPoint (context, startx+arc4random_uniform(2*deviation), starty+thickness-arc4random_uniform(2*deviation));
    CGContextAddLineToPoint (context, endx-arc4random_uniform(2*deviation), endy+thickness-arc4random_uniform(2*deviation));
    CGContextAddLineToPoint (context, endx-arc4random_uniform(2*deviation), endy-thickness+arc4random_uniform(2*deviation));
    CGContextClosePath (context);
    CGContextDrawPath (context,	kCGPathFillStroke);
    
    //bottom
    startx = 0;
    endx = width;
    starty = 2*height/3;
    endy = 2*height/3;
    CGContextBeginPath (context);
    CGContextMoveToPoint    (context, startx+arc4random_uniform(2*deviation), starty-thickness+arc4random_uniform(2*deviation));
    CGContextAddLineToPoint (context, startx+arc4random_uniform(2*deviation), starty+thickness-arc4random_uniform(2*deviation));
    CGContextAddLineToPoint (context, endx-arc4random_uniform(2*deviation), endy+thickness-arc4random_uniform(2*deviation));
    CGContextAddLineToPoint (context, endx-arc4random_uniform(2*deviation), endy-thickness+arc4random_uniform(2*deviation));
    CGContextClosePath (context);
    CGContextDrawPath (context,	kCGPathFillStroke);
}

- (void)jitter{
    [self setNeedsDisplay];
}

@end
