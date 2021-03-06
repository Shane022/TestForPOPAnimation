//
//  SingerInfoController.m
//  TestForPop
//
//  Created by Shane on 2019/4/29.
//  Copyright © 2019 Shane. All rights reserved.
//

#import "SingerInfoController.h"
#import <UIView+YYAdd.h>
#import "Chameleon.h"

#import "CountDownUtil.h"

typedef NS_ENUM(NSInteger, Direction) {
    DotViewDirectionLeft = 1,
    DotViewDirectionRight = -1
};

@interface SingerInfoController ()

@property (nonatomic, strong) CountDownUtil *countdownUtil;

@property (nonatomic, strong) UILabel *hourLabel;
@property (nonatomic, strong) UILabel *minuteLabel;
@property (nonatomic, strong) UILabel *secondLabel;

@end

@implementation SingerInfoController
{
    CADisplayLink *_link;
    NSMutableArray *_arrDots;
    
    CGFloat _startPointX;
    CGFloat _endPointX;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self testForCADisplayLink];
    
    [self testForCountDown];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self stopLink];
}

#pragma mark - Test for count down
- (void)testForCountDown
{
    [self setupCountdownView];
    
    NSString *start = @"2019-5-17 14:06:00";
    NSString *end = @"2019-5-17 14:07:00";
    
    __weak typeof(self) weakSelf = self;
    self.countdownUtil = [[CountDownUtil alloc] init];
    [self.countdownUtil countDownWithStartDate:start endDate:end completed:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        [weakSelf refreshCountdownViewWithHour:hour minute:minute second:second];
    }];
}

- (void)setupCountdownView
{
    NSInteger number = 3;
    CGFloat viewWidth = 40;
    CGFloat viewHeight = 120;
    CGFloat viewGap = 10;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat leftGap = (screenSize.width - viewWidth * number - viewGap * (number - 1)) / 2;
    CGFloat topGap = 200;
    
    for (NSInteger i = 0; i < number; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftGap + (viewGap + viewWidth) * i, topGap, viewWidth, viewHeight)];
        label.text = @"00";
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor flatBlackColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:16];
        
        if (i == 0) {
            self.hourLabel = label;
        } else if (i == 1) {
            self.minuteLabel = label;
        } else if (i == 2) {
            self.secondLabel = label;
        }
        
        [self.view addSubview:label];
    }
}

- (void)refreshCountdownViewWithHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    self.hourLabel.text = [NSString stringWithFormat:@"%02ld", hour];
    self.minuteLabel.text = [NSString stringWithFormat:@"%02ld", minute];
    self.secondLabel.text = [NSString stringWithFormat:@"%02ld", second];
}

#pragma mark - Test for CADisplayLink
- (void)testForCADisplayLink
{
    _arrDots = [NSMutableArray arrayWithCapacity:0];
    NSInteger number = 2;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat dotWidth = 40;
    CGFloat dotViewGap = 15;
    CGFloat topGap = 150;
    CGFloat leftGap = (screenSize.width - dotWidth * number - dotViewGap) / 2;
    
    NSArray *arrColors = @[[UIColor flatRedColor], [UIColor flatSkyBlueColor]];
    
    for (NSInteger i = 0; i < number; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(leftGap + (dotViewGap + dotWidth) * i, topGap, dotWidth, dotWidth)];
        dotView.backgroundColor = arrColors[i];
        [_arrDots addObject:dotView];
        [self.view addSubview:dotView];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:dotView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(dotWidth / 2, dotWidth / 2)];
        CAShapeLayer *dotLayer = [CAShapeLayer layer];
        dotLayer.frame = dotView.bounds;
        dotLayer.path = path.CGPath;
        dotView.layer.mask = dotLayer;
        
        [self addAnimationForDotView:dotView];
        
        if (i == 0) {
            [self.view bringSubviewToFront:dotView];
            dotView.tag = DotViewDirectionLeft;
        } else {
            [self.view sendSubviewToBack:dotView];
            dotView.tag = DotViewDirectionRight;
        }
    }
    
    
    [self startLink];
}

- (void)addAnimationForDotView:(UIView *)dotView
{
    NSInteger number = 2;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat dotWidth = 40;
    CGFloat dotViewGap = 20;
    CGFloat leftGap = (screenSize.width - dotWidth * number - dotViewGap) / 2;
    CGFloat wholePath = leftGap + dotWidth * number + dotViewGap;
    CGFloat startPoint = dotView.tag == DotViewDirectionLeft ? leftGap : wholePath;
    CGFloat endPoint = dotView.tag == DotViewDirectionLeft ? wholePath : leftGap;
    _startPointX = (leftGap + dotWidth / 2);
    _endPointX = (wholePath - dotWidth / 2);
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    keyAnimation.duration = 10.f;
    keyAnimation.repeatCount = CGFLOAT_MAX;
    keyAnimation.values = @[@(startPoint), @(endPoint), @(startPoint)];
    
//    [dotView.layer addAnimation:keyAnimation forKey:@"positionX"];
}

- (void)startLink
{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(positionAnimation)];
    }
    [_link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopLink
{
    [_link removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    _link = nil;
}

- (void)positionAnimation
{
    UIView *leftDotView = _arrDots.firstObject;
    UIView *rightDotView = _arrDots.lastObject;
    
    NSInteger leftDirection = leftDotView.tag;
    NSInteger rightDirection = rightDotView.tag;
    
    NSInteger number = 2;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat dotWidth = 40;
    CGFloat dotViewGap = 20;
    CGFloat leftGap = (screenSize.width - dotWidth * number - dotViewGap) / 2;
    CGFloat wholePath = leftGap + dotWidth * number + dotViewGap;
    CGFloat startCenterX = leftGap + dotWidth / 2;
    CGFloat endCenterX = wholePath - dotWidth / 2;
    
    CGPoint leftDotCenter = leftDotView.center;
    CGPoint rightDotCenter = rightDotView.center;
    
    if (leftDotCenter.x >= endCenterX || leftDotCenter.x < startCenterX) {
        leftDirection = -1 * leftDirection;
        if (leftDirection < 0) {
            [self.view sendSubviewToBack:leftDotView];
            [self.view bringSubviewToFront:rightDotView];
        }
    }
    
    if (rightDotCenter.x <= startCenterX || rightDotCenter.x > endCenterX) {
        rightDirection = -1 * rightDirection;
        if (rightDirection < 0) {
            [self.view sendSubviewToBack:rightDotView];
            [self.view bringSubviewToFront:leftDotView];
        }
    }

    leftDotCenter.x += leftDirection * 2;
    leftDotView.center = leftDotCenter;
    
    rightDotCenter.x += rightDirection * 2;
    rightDotView.center = rightDotCenter;
    
    leftDotView.tag = leftDirection;
    rightDotView.tag = rightDirection;
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

@end
