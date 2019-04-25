//
//  TestViewController.m
//  TestForPop
//
//  Created by Shane on 2019/4/16.
//  Copyright © 2019 Shane. All rights reserved.
//

#import "TestViewController.h"
#import "YYText.h"
#import "TwoSidesView.h"
#import <ChameleonFramework/Chameleon.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kDegreesToRadians(x) (M_PI*(x)/180.0)                 //把角度转换成PI的方式

static CGFloat imageWidth = 200;
static CGFloat sectorWidth = 200;

@interface TestViewController ()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) TwoSidesView *twoSidesView;


@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    
    // test
//    [self testForScale];
//    [self testForPosition];
//    [self testForGradientLayer];
//    [self testForTextLayer];
    
    // 扇形
//    [self testForSector];
    
    // 贝塞尔曲线
//    [self testForBezierPath];
    
    
    
//    [self testForUIView];
    
//    [self testForCoin];
    
//    [self testTwoSides];
    
//    [self testForLayerAction];
    
    [self testForChameleon];
}

#pragma mark -
- (void)setupSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:self.coverImageView];
    
    [self testForCoverImageWithAnimated:NO];
}

#pragma mark - Test Demo
- (void)testForChameleon
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    UIImage *image = [UIImage imageNamed:@"cover"];
    imageView.image = image;
    NSArray *arrColors = [NSArray arrayOfColorsFromImage:image withFlatScheme:YES];
    NSLog(@"image colors is :%@", arrColors);
    [self.view addSubview:imageView];
}

- (void)testForLayerAction
{
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];
    // null
    NSLog(@"%@", [testView actionForLayer:testView.layer forKey:@"position"]);
    
    [UIView animateWithDuration:1.5 animations:^{
        // _UIViewAdditiveAnimationAction
        NSLog(@"%@", [testView actionForLayer:testView.layer forKey:@"position"]);
    }];
}

- (void)testTwoSides
{
    self.twoSidesView = [[TwoSidesView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:self.twoSidesView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.twoSidesView startOverturnWithDuration:0.8];
}

- (void)testForCoin
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 32, 32)];
    UIImage *coinImage = [UIImage imageNamed:@"coin"];
    imageView.image = coinImage;
    [self.view addSubview:imageView];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animation.repeatCount = CGFLOAT_MAX;
    animation.duration = 1.5;
    animation.fromValue = @(0);
    animation.toValue = @(2 * M_PI);

    [imageView.layer addAnimation:animation forKey:@"transform"];
    
    
    // test
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 200, 60)];
    bgView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bgView];
    
    CGFloat dotWidth = 20;
    CALayer *dotLayer = [CALayer layer];
    dotLayer.bounds = CGRectMake(0, 0, dotWidth, dotWidth);
    dotLayer.cornerRadius = dotWidth / 2;
    dotLayer.masksToBounds = YES;
    dotLayer.position = CGPointMake(dotWidth, bgView.frame.size.height - dotWidth / 2);
    dotLayer.backgroundColor = [UIColor blackColor].CGColor;
    
    CGFloat bottomPosition = bgView.frame.size.height - dotWidth / 2;
    CGFloat topPosition = dotWidth / 2;
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnimation.fromValue = @(bottomPosition);
    positionAnimation.toValue = @(topPosition);
    positionAnimation.repeatCount = CGFLOAT_MAX;
    positionAnimation.autoreverses = YES;
    positionAnimation.duration = 0.6;
    [dotLayer addAnimation:positionAnimation forKey:@"positionY"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    [replicatorLayer addSublayer:dotLayer];
    replicatorLayer.frame = bgView.bounds;
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(30, 0, 0);
    replicatorLayer.instanceDelay = 0.3;
    
    [bgView.layer addSublayer:replicatorLayer];
}

- (void)testForUIView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(100.125456, 100.429903123123, 100.12134, 100.282526)];
    bgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgView];
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    subView.backgroundColor = [UIColor greenColor];
    [bgView addSubview:subView];
    
//    bgView.alpha = 0.3;
//    bgView.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.1];
}

- (void)testForBezierPath
{
#if 0
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:60 startAngle:M_PI endAngle:M_PI * 3/2 clockwise:YES];
    path.lineWidth     = 5.f;
    path.lineCapStyle  = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
#else
    UIBezierPath *path = [UIBezierPath bezierPath]; // 创建路径
    
    [path moveToPoint:CGPointMake(100, 100)]; // 设置起始点
    
    [path addArcWithCenter:CGPointMake(100, 100) radius:75 startAngle:0 endAngle:3.14159/2 clockwise:NO]; // 绘制一个圆弧
    
    path.lineWidth     = 5.0;
    path.lineCapStyle  = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineCapRound; //终点处理
#endif
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(100, 100, 100, 100);
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.path = path.CGPath;
    layer.lineWidth = 5.f;
    layer.fillColor = [UIColor clearColor].CGColor;

    [self.view.layer addSublayer:layer];
}

- (void)testForSector
{
    UIBezierPath *bezPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(sectorWidth/2, sectorWidth/2) radius:sectorWidth / 2 startAngle:kDegreesToRadians(270) endAngle:kDegreesToRadians(270) + kDegreesToRadians(180) clockwise:YES];
    [bezPath addLineToPoint:CGPointMake(sectorWidth / 2, sectorWidth / 2)];// 扇形关键代码
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(100, 100, sectorWidth, sectorWidth);
    shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    shapeLayer.path  = bezPath.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    _shapeLayer = shapeLayer;
    
    _progress = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.018 target:self selector:@selector(actionSectorTimer) userInfo:nil repeats:YES];
    [_timer fire];
}

- (void)actionSectorTimer {
    _progress +=1;
    UIBezierPath *bezPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(sectorWidth / 2, sectorWidth / 2) radius:150 startAngle:kDegreesToRadians(270) endAngle:kDegreesToRadians(270) + kDegreesToRadians(_progress) clockwise:YES];
    [bezPath addLineToPoint:CGPointMake(sectorWidth / 2, sectorWidth / 2)];// 扇形关键代码
    _shapeLayer.path = bezPath.CGPath;
    if (_progress >= 360) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)testForGradientLayer
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:bgView];
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.bounds = bgView.bounds;
    layer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id) [UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    layer.locations = @[@0.0, @0.25, @1.0];
//    layer.startPoint = CGPointMake(0, 0);
//    layer.endPoint = CGPointMake(1, 1);
    [bgView.layer addSublayer:layer];
}

- (void)testForTextLayer
{
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.string = @"沉舟侧畔千帆过，病树前头万木春";
    textLayer.frame = CGRectMake(100, 100, 300, 30);
    textLayer.fontSize = 15.f;
    textLayer.foregroundColor = [UIColor blueColor].CGColor;
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    [self.view.layer addSublayer:textLayer];
    
}

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
