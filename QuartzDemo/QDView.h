//
//  QDView.h
//  QuartzDemo
//
//  Created by Artem Rakhmatulin on 04/04/2020.
//  Copyright © 2020 Rakhmatulin Artem Timurovich IP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDConstants.h"
#import "UIColor+UIColor_QDRandom.h"

NS_ASSUME_NONNULL_BEGIN

@interface QDView : UIView

#pragma mark - Getters

- (CGPoint)firstTouch;
- (CGPoint)lastTouch;
- (UIColor *)currentColor;
- (ShapeType)shapeType;
- (UIImage *)drawImage;
- (BOOL)useRandomColor;

- (UISegmentedControl *)colorSegmentedControl;
- (UISegmentedControl *)shapeSegmentedControl;

#pragma mark - Setters

- (void)setCurrentColor:(UIColor *)color;
- (void)setShapeType:(ShapeType)t;
- (void)setUseRandomColor:(BOOL)b;

@end

NS_ASSUME_NONNULL_END
