//
//  QDViewController.m
//  QuartzDemo
//
//  Created by Artem Rakhmatulin on 04/04/2020.
//  Copyright © 2020 Rakhmatulin Artem Timurovich IP. All rights reserved.
//

#import "QDViewController.h"

@interface QDViewController ()
{
    QDView *_v;
}

- (QDView *)v;

@end

@implementation QDViewController

- (QDView *)v
{
    return _v;
} //v

- (void)loadView
{
    _v = [[QDView alloc] init];
    [self setView:_v];
} //loadView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[_v colorSegmentedControl] addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventValueChanged];
    [[_v shapeSegmentedControl] addTarget:self action:@selector(changeShape:) forControlEvents:UIControlEventValueChanged];
} //viewDidLoad

#pragma mark - Actions for Control Events

- (void)changeColor:(UISegmentedControl *)control
{
    NSUInteger index = [control selectedSegmentIndex];
    switch (index) {
        case kRedColorTab:
            [_v setCurrentColor:[UIColor redColor]];
            break;
        case kBlueColorTab:
            [_v setCurrentColor:[UIColor blueColor]];
            break;
        case kYellowColorTab:
            [_v setCurrentColor:[UIColor yellowColor]];
            break;
        case kGreenColorTab:
            [_v setCurrentColor:[UIColor greenColor]];
            break;
        case kRandomColorTab:
            [_v setCurrentColor:[UIColor randomColor]];
            [_v setUseRandomColor:YES];
            break;
    }
} //changeColor

- (void)changeShape:(UISegmentedControl *)control
{
    NSUInteger index = [control selectedSegmentIndex];
    [_v setShapeType:index];
    [[_v colorSegmentedControl] setEnabled:!(kImageShape == index)];
} //changeShape

@end
