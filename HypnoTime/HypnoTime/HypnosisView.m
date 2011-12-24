//
//  HypnosisView.m
//  Hypnotizer
//
//  Created by Tammer Saleh on 12/22/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView
@synthesize xShift, yShift;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        stripeColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = [self bounds];
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10);
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [stripeColor setStroke];
        
        center.x += xShift;
        center.y += yShift;
        
        CGContextAddArc(context, center.x, center.y, currentRadius, 0.0, M_PI * 2.0, YES);
        CGContextStrokePath(context);
    }
    NSString *text = @"You're getting sleepy!";
    UIFont *font = [UIFont boldSystemFontOfSize:28];
    
    CGRect textRect;
    textRect.size = [text sizeWithFont:font];
    textRect.origin.x = center.x - textRect.size.width / 2.0;
    textRect.origin.y = center.y - textRect.size.height / 2.0;
    
    [[UIColor blackColor] setFill];
    
    CGSize offset = CGSizeMake(4, 3);
    CGColorRef color = [[UIColor darkGrayColor] CGColor];
    CGContextSetShadowWithColor(context, offset, 2.0, color);
    
    [text drawInRect:textRect withFont:font];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (UIEventSubtypeMotionShake == motion) {
        float r,g,b;
        r = random() % 256 / 256.0;
        g = random() % 256 / 256.0;
        b = random() % 256 / 256.0;
        stripeColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
        [self setNeedsDisplay]; 
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
@end
