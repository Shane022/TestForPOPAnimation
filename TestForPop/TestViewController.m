//
//  TestViewController.m
//  TestForPop
//
//  Created by Shane on 2019/4/16.
//  Copyright © 2019 Shane. All rights reserved.
//

#import "TestViewController.h"
#import "YYText.h"

static CGFloat imageWidth = 200;

@interface TestViewController ()

@property (nonatomic, strong) UIImageView *coverImageView;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    
    // test
    [self testForScale];
//    [self testForPosition];
}

#pragma mark -
- (void)setupSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.coverImageView];
    
    [self testForCoverImageWithAnimated:YES];
}

#pragma mark - Test Demo

- (void)testForCoverImageWithAnimated:(BOOL)animated
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 5;
    animation.repeatCount = CGFLOAT_MAX;
    animation.fromValue = @(0);
    animation.toValue = @(2 * M_PI);
    if (animated) {
        [self.coverImageView.layer addAnimation:animation forKey:@"coverImageRotation"];
    }
}

- (void)testForPosition
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.duration = 1.5;
    animation.repeatCount = CGFLOAT_MAX;
    animation.autoreverses = YES;
    animation.fromValue = @(180);
    animation.toValue = @(self.view.frame.size.height);
    [self.coverImageView.layer addAnimation:animation forKey:@"positionY"];
}

- (void)testForScale
{
    CGFloat width = imageWidth + 10;
    CGFloat dotWidth = 10;
    CGRect rect = CGRectMake(0, 0, width, width);
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    UIBezierPath *dotPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, dotWidth, dotWidth)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.bounds = rect;
    layer.position = CGPointMake(screenSize.width / 2, screenSize.height / 2);
    layer.path = path.CGPath;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth = 3;

    CAShapeLayer *dotLayer = [CAShapeLayer layer];
    dotLayer.bounds = CGRectMake(0, 0, dotWidth, dotWidth);
    dotLayer.position = CGPointMake(layer.frame.origin.x, 0);
    dotLayer.path = dotPath.CGPath;
    dotLayer.strokeColor = [UIColor blueColor].CGColor;
    dotLayer.fillColor = [UIColor blueColor].CGColor;
    [layer addSublayer:dotLayer];

    
    CFTimeInterval duration = 3;
    
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.duration = duration;
    theAnimation.fromValue = [NSNumber numberWithFloat:1];
    theAnimation.toValue = [NSNumber numberWithFloat:1.5];
    theAnimation.repeatCount = CGFLOAT_MAX;
    theAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *hideAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    hideAnimation.duration = duration;
    hideAnimation.fromValue = @(1);
    hideAnimation.toValue = @(0);
    hideAnimation.repeatCount = CGFLOAT_MAX;
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.duration = duration;
    rotationAnimation.fromValue = @(0);
    rotationAnimation.toValue = @(M_PI);
    rotationAnimation.repeatCount = CGFLOAT_MAX;
    
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.duration = duration;
    group.repeatCount = CGFLOAT_MAX;
    [group setAnimations:@[theAnimation, hideAnimation, rotationAnimation]];
    
    [layer addAnimation:group forKey:@"group"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceDelay = 1.8;
    replicatorLayer.repeatCount = CGFLOAT_MAX;
    [replicatorLayer addSublayer:layer];
    
    [self.view.layer addSublayer:replicatorLayer];
}


#pragma mark - Lazy Load
- (UIImageView *)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageWidth)];
        _coverImageView.backgroundColor = [UIColor redColor];
        UIImage *image = [UIImage imageNamed:@"cover"];
        _coverImageView.image = image;
        _coverImageView.center = self.view.center;
        _coverImageView.layer.cornerRadius = imageWidth / 2;
        _coverImageView.layer.masksToBounds = YES;
    }
    
    return _coverImageView;
}



@end
