//
//  QDConstants.h
//  QuartzDemo
//
//  Created by Artem Rakhmatulin on 04/04/2020.
//  Copyright © 2020 Rakhmatulin Artem Timurovich IP. All rights reserved.
//

#ifndef QDConstants_h
#define QDConstants_h

typedef enum: NSUInteger {
    kLineShape = 0,
    kRectShape,
    kEllipseShape,
    kImageShape
} ShapeType;

typedef enum: NSUInteger {
    kRedColorTab = 0,
    kBlueColorTab,
    kYellowColorTab,
    kGreenColorTab,
    kRandomColorTab
} ColorTabIndex;

#define degreesToRadian(x) (M_PI * (x) / 180.0)

#endif /* QDConstants_h */
