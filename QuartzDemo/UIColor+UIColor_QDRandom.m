//
//  UIColor+UIColor_QDRandom.m
//  QuartzDemo
//
//  Created by Artem Rakhmatulin on 04/04/2020.
//  Copyright © 2020 Rakhmatulin Artem Timurovich IP. All rights reserved.
//

#import "UIColor+UIColor_QDRandom.h"

CGFloat randomFloat()
{
    return (CGFloat)random()/(CGFloat)RAND_MAX;
}

@implementation UIColor (UIColor_QDRandom)

+ (UIColor *)randomColor
{
    static BOOL seeded = NO;
    if (!seeded) {
        srandom((unsigned int)time(NULL));
        seeded = YES;
    }
    
    CGFloat red = randomFloat(), green = randomFloat(), blue = randomFloat();
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
    
    return color;
}

@end
