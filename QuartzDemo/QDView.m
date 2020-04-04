//
//  QDView.m
//  QuartzDemo
//
//  Created by Artem Rakhmatulin on 04/04/2020.
//  Copyright © 2020 Rakhmatulin Artem Timurovich IP. All rights reserved.
//

#import "QDView.h"

@interface QDView ()
{
    CGPoint _firstTouch;
    CGPoint _lastTouch;
    UIColor *_currentColor;
    ShapeType _shapeType;
    UIImage *_drawImage;
    BOOL _useRandomColor;
    
    UISegmentedControl *_colorSegmentedControl;
    UISegmentedControl *_shapeSegmentedControl;
    
    CGRect _currentRect;
    CGRect _redrawRect;
}

#pragma mark - Private Getters

- (CGRect)currentRect;

@end

@implementation QDView

#pragma mark - Getters

- (CGPoint)firstTouch
{
    return _firstTouch;
} //firstTouch

- (CGPoint)lastTouch
{
    return _lastTouch;
} //lastTouch

- (UIColor *)currentColor
{
    return _currentColor;
} //currentColor

- (ShapeType)shapeType
{
    return _shapeType;
} //shapeType

- (UIImage *)drawImage
{
    return _drawImage;
} //drawImage

- (BOOL)useRandomColor
{
    return _useRandomColor;
} //useRandomColor

- (UISegmentedControl *)colorSegmentedControl
{
    return _colorSegmentedControl;
} //colorSegmentedControl

- (UISegmentedControl *)shapeSegmentedControl
{
    return _shapeSegmentedControl;
} //shapeSegmentedControl

- (CGRect)currentRect
{
    _currentRect = CGRectMake(_firstTouch.x,
                              _firstTouch.y,
                              _lastTouch.x - _firstTouch.x,
                              _lastTouch.y - _firstTouch.y);
    _redrawRect = CGRectUnion(_redrawRect, _currentRect);
    return _currentRect;
} //currentRect

#pragma mark - Setters

- (void)setCurrentColor:(UIColor *)color
{
    _currentColor = color;
    _useRandomColor = NO;
} //setCurrentColor

- (void)setShapeType:(ShapeType)t
{
    _shapeType = t;
} //setShapeType

- (void)setUseRandomColor:(BOOL)b
{
    _useRandomColor = b;
} //setUseRandomColor

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentColor = [UIColor redColor];
        _useRandomColor = NO;
        _drawImage = [UIImage imageNamed:@"selfie.png"];
        
        _colorSegmentedControl = [[UISegmentedControl alloc] init];
        _shapeSegmentedControl = [[UISegmentedControl alloc] init];
        
        [self setupViews];
    }
    return self;
} //initWithFrame:

#pragma mark -

- (void)setupViews
{
    
#pragma mark - Layout Views
    
    [self addSubview:_colorSegmentedControl];
    [self addSubview:_shapeSegmentedControl];
    
    [_colorSegmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_shapeSegmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSArray<NSLayoutConstraint *> *constraints = @[
        [_colorSegmentedControl.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor constant:8.0f],
        [_colorSegmentedControl.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8.0f],
        [_colorSegmentedControl.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8.0f],
        
        [_shapeSegmentedControl.bottomAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.bottomAnchor constant:-8.0f],
        [_shapeSegmentedControl.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8.0f],
        [_shapeSegmentedControl.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8.0f]
    ];
    
    [NSLayoutConstraint activateConstraints:constraints];
    
#pragma mark - Setup Views
    
    [_colorSegmentedControl insertSegmentWithTitle:@"Red" atIndex:kRedColorTab animated:NO];
    [_colorSegmentedControl insertSegmentWithTitle:@"Blue" atIndex:kBlueColorTab animated:NO];
    [_colorSegmentedControl insertSegmentWithTitle:@"Yellow" atIndex:kYellowColorTab animated:NO];
    [_colorSegmentedControl insertSegmentWithTitle:@"Green" atIndex:kGreenColorTab animated:NO];
    [_colorSegmentedControl insertSegmentWithTitle:@"Random" atIndex:kRandomColorTab animated:NO];
    
    [_shapeSegmentedControl insertSegmentWithTitle:@"Line" atIndex:kLineShape animated:NO];
    [_shapeSegmentedControl insertSegmentWithTitle:@"Rect" atIndex:kRectShape animated:NO];
    [_shapeSegmentedControl insertSegmentWithTitle:@"Ellipse" atIndex:kEllipseShape animated:NO];
    [_shapeSegmentedControl insertSegmentWithTitle:@"Image" atIndex:kImageShape animated:NO];
    
    [_colorSegmentedControl setSelectedSegmentIndex:kRedColorTab];
    [_shapeSegmentedControl setSelectedSegmentIndex:kLineShape];
    
#pragma mark - Style Views
    
    [self setBackgroundColor:[UIColor whiteColor]];
} //setupViews


#pragma mark - Touches Handling

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (1 == [touches count]) {
        UITouch *touch = [touches anyObject];
        _firstTouch = [touch locationInView:self];
        _lastTouch = [touch locationInView:self];
        [self setNeedsDisplayInRect:_redrawRect];
    }
} //touchesBegan:withEvent:

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (1 == [touches count]) {
        UITouch *touch = [touches anyObject];
        _lastTouch = [touch locationInView:self];
        [self setNeedsDisplayInRect:_redrawRect];
    }
} //touchesMoved:withEvent:

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (1 == [touches count]) {
        UITouch *touch = [touches anyObject];
        _lastTouch = [touch locationInView:self];
        [self setNeedsDisplayInRect:_redrawRect];
    }
} //touchesEnded:withEvent:

#pragma mark - Custom Drawing

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2.0f);
    CGContextSetStrokeColorWithColor(context, [_currentColor CGColor]);
    CGContextSetFillColorWithColor(context, [_currentColor CGColor]);
    
    switch (_shapeType) {
        case kLineShape:
            [self currentRect];
            CGContextMoveToPoint(context, _firstTouch.x, _firstTouch.y);
            CGContextAddLineToPoint(context, _lastTouch.x, _lastTouch.y);
            CGContextStrokePath(context);
            break;
        case kRectShape:
            CGContextAddRect(context, [self currentRect]);
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        case kEllipseShape:
            CGContextAddEllipseInRect(context, [self currentRect]);
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        case kImageShape:
        {
            CGRect currentRect = [self currentRect];
            
            if (currentRect.size.height < 0.0f) {
                currentRect.origin.y += currentRect.size.height;
                currentRect.size.height *= -1.0f;
            }
            
            if (currentRect.size.width < 0.0f) {
                currentRect.origin.x += currentRect.size.width;
                currentRect.size.width *= -1.0f;
            }
            
            UIImage *img = [UIImage imageNamed:@"selfie.png"];
            [img drawInRect:currentRect];
        }
    }
} //drawRect

@end
