//
//  ViewController.m
//  TestForPop
//
//  Created by Shane on 2019/4/1.
//  Copyright © 2019 Shane. All rights reserved.
//

#import "ViewController.h"
#import <pop/POP.h>
#import "ClockFace.h"
#import "TestViewController.h"
#import "MusicViewController.h"
#import "ColorController.h"
#import <ChameleonFramework/Chameleon.h>

@interface ViewController ()

@property (nonatomic, strong) UIView *baseView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) ClockFace *clockFace;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIButton *btnSkip;
@property (nonatomic, strong) UIButton *btnSkipMusic;
@property (nonatomic, strong) UIButton *btnSkipColor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    
//    [self.view addSubview:self.baseView];
//    [self testForPopAnimation];
    
    [self testForClock];
    
//    NSString *url = @"http://www.baidu.com/";
//    NSURLComponents *components = [NSURLComponents componentsWithString:url];
//    NSLog(@"%@", components);
    
//    [self testForAnimation];

    
//    [self testForShapeLayer];
    
//    [self testForLayerRotation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopAction:nil];
}

- (void)setupSubViews
{
    [self.view addSubview:self.btnSkip];
    [self.view addSubview:self.btnSkipMusic];
    [self.view addSubview:self.btnSkipColor];
}

- (void)onHitBtnSkip:(UIButton *)sender
{
    TestViewController *testVC = [[TestViewController alloc] init];
    [self.navigationController pushViewController:testVC animated:YES];
}

- (void)onHitBtnSkipMusic:(UIButton *)sender
{
    MusicViewController *musicVC = [[MusicViewController alloc] init];
    [self.navigationController pushViewController:musicVC animated:YES];
}

- (void)onHitBtnSkipColor:(UIButton *)sender
{
    ColorController *colorVC = [[ColorController alloc] init];
    [self.navigationController pushViewController:colorVC animated:YES];
}

#pragma mark -

- (void)testForLayerRotation
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(250, 270, 100, 100)];
    bgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgView];
    
    // X
#if 0
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    theAnimation.duration=8;
    theAnimation.removedOnCompletion = YES;
    theAnimation.fromValue = [NSNumber numberWithFloat:0];
    theAnimation.toValue = [NSNumber numberWithFloat:3.1415926];
    [bgView.layer addAnimation:theAnimation forKey:@"animateTransform"];
#endif
    // Y
#if 0
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    theAnimation.duration=8;
    theAnimation.removedOnCompletion = YES;
    theAnimation.fromValue = [NSNumber numberWithFloat:0];
    theAnimation.toValue = [NSNumber numberWithFloat:3.1415926];
    [bgView.layer addAnimation:theAnimation forKey:@"animateTransform"];
#endif
    // Z
#if 1
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    theAnimation.duration = 3;
    theAnimation.removedOnCompletion = YES;
    theAnimation.fromValue = [NSNumber numberWithFloat:0];
    theAnimation.toValue = [NSNumber numberWithFloat:M_PI];
    theAnimation.repeatCount = CGFLOAT_MAX;
    [bgView.layer addAnimation:theAnimation forKey:@"animateTransform"];
#endif
}

- (void)testForShapeLayer
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(150, 170, 100, 100)];
//    bgView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgView];
    
#if 0
    // 不同位置的圆角
    CGRect shapeLayerRect = CGRectMake(0, 0, 200, 300);
    shapeLayerRect = bgView.bounds;
    CGFloat radius = bgView.frame.size.width / 2;
    UIRectCorner corner = UIRectCornerTopLeft | UIRectCornerBottomRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:shapeLayerRect byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    const CGFloat dash = 5.0;
    [path setLineDash:&dash count:20 phase:4];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = shapeLayerRect;
    shapeLayer.path = path.CGPath;
    [shapeLayer setFillColor:[UIColor purpleColor].CGColor];
    
    bgView.layer.mask = shapeLayer;
#endif
    
#if 1
    // 进度条动画
    // 创建CAShapeLayer
    CAShapeLayer *loadingLayer = [CAShapeLayer layer];
    loadingLayer.bounds = bgView.bounds;
    loadingLayer.fillColor = [UIColor clearColor].CGColor;
    loadingLayer.strokeColor = [UIColor redColor].CGColor;
    loadingLayer.lineWidth = 2;
    // 添加路径
    CGPathRef path = [UIBezierPath bezierPathWithOvalInRect:bgView.bounds].CGPath;
    loadingLayer.path = path;
    loadingLayer.position = bgView.center;
    [bgView.layer addSublayer:loadingLayer];
    
    // 添加动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 1.5;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.fromValue = @(0.0);
    animation.toValue = @(0.7);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.repeatCount = CGFLOAT_MAX;
    [loadingLayer addAnimation:animation forKey:nil];
    
#endif
}

- (void)testForAnimation
{
    // 0.创建背景view
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor grayColor];
    CGFloat bgViewX = self.view.frame.size.width * 0.5  ;
    CGFloat bgViewY = 300;
    CGFloat bgViewW = 200;
    CGFloat bgViewH = 200;
    bgView.center = CGPointMake(bgViewX, bgViewY);
    bgView.bounds = CGRectMake(0, 0, bgViewW, bgViewH);
    [self.view addSubview:bgView];
    
    // 1.创建复制图层 可以把图层里面所有子层复制
    CAReplicatorLayer *repL = [CAReplicatorLayer layer];
    repL.frame = bgView.bounds;
    [bgView.layer addSublayer:repL];
    
    CALayer *layer = [CALayer layer];
    layer.anchorPoint = CGPointMake(0.5, 1);
    layer.position = CGPointMake(15, bgView.bounds.size.height);
    layer.bounds = CGRectMake(0, 0, 10, 150);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [repL addSublayer:layer];
    
    // 2.创建动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";
    anim.toValue = @0.1;
    anim.duration = 0.3;
    anim.repeatCount = MAXFLOAT;
    
    // 设置反转动画
    anim.autoreverses = YES;
    [layer addAnimation:anim forKey:nil];
    
    // 复制层中子层总数
    // instanceCount：表示复制层里面有多少个子层，包括原始层
    repL.instanceCount = 3;
    
    // 设置复制子层偏移量，不包括原始层,相对于原始层x偏移
    repL.instanceTransform = CATransform3DMakeTranslation(15, 0, 0);
    
    // 设置复制层动画延迟时间
    repL.instanceDelay = 0.1;
    
    // 如果设置了原始层背景色，就不需要设置这个属性
    repL.instanceColor = [UIColor greenColor].CGColor;
    
//    repL.instanceGreenOffset = -0.3;
}

#pragma mark - Test for Clock
- (void)testForClock
{
    // 添加时钟面板 Layer
    self.clockFace = [[ClockFace alloc] init];
    self.clockFace.position = CGPointMake(self.view.bounds.size.width / 2, 200);
    [self.view.layer addSublayer:self.clockFace];
    
    // 设置默认时间
    self.clockFace.time = [NSDate date];
    
    //
    [self startAction:nil];
}

- (IBAction)setTime:(id)sender {
    [self stopAction:nil];
    self.clockFace.time = self.datePicker.date;
}

- (IBAction)startAction:(id)sender {
    [self stopAction:nil];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.clockFace.time = [NSDate date];
    }];
}

- (IBAction)stopAction:(id)sender {
    if ([self.timer isValid]) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark -
- (void)testForPopAnimation
{
#if 0
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor greenColor].CGColor;
    layer.frame = CGRectMake(0, 0, 100, 100);
    [self.view.layer addSublayer:layer];
    
    layer.frame = CGRectOffset(layer.frame, 100, 0);
#endif
    
    CGFloat positionX = 100;
    CGFloat positionY = 100;
    
    POPBasicAnimation *xAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    xAnimation.toValue = @(positionX);
    [self.baseView pop_addAnimation:xAnimation forKey:kPOPLayerPositionX];
    
    POPBasicAnimation *yAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    yAnimation.toValue = @(positionY);
    [self.baseView pop_addAnimation:yAnimation forKey:kPOPLayerPositionY];
    
    POPSpringAnimation *sizeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    sizeAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(positionX, positionY, 400, 400)];
//    [self.baseView pop_addAnimation:sizeAnimation forKey:@"size"];
    
    POPDecayAnimation *slideAnimation = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    slideAnimation.velocity = @(1000.);
    [self.baseView pop_addAnimation:slideAnimation forKey:@"slide"];
    
}

#pragma mark - Lazy Load
- (UIView *)baseView
{
    if (_baseView == nil) {
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _baseView.backgroundColor = [UIColor redColor];
    }
    
    return _baseView;

}

- (UIButton *)btnSkip
{
    if (!_btnSkip) {
        CGFloat btnWidth = 60;
        CGFloat btnHeight = 30;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _btnSkip = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSkip.frame = CGRectMake(screenSize.width - btnWidth - 16, 100, btnWidth, btnHeight);
        [_btnSkip setTitle:@"skip" forState:UIControlStateNormal];
        [_btnSkip setBackgroundColor:[UIColor flatLimeColor]];
        [_btnSkip addTarget:self action:@selector(onHitBtnSkip:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnSkip;
}

- (UIButton *)btnSkipMusic
{
    if (!_btnSkipMusic) {
        CGFloat btnWidth = 60;
        CGFloat btnHeight = 30;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _btnSkipMusic = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSkipMusic.frame = CGRectMake(screenSize.width - btnWidth - 16, 180, btnWidth, btnHeight);
        [_btnSkipMusic setTitle:@"music" forState:UIControlStateNormal];
        [_btnSkipMusic setBackgroundColor:[UIColor flatMintColor]];
        [_btnSkipMusic addTarget:self action:@selector(onHitBtnSkipMusic:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnSkipMusic;
}


- (UIButton *)btnSkipColor
{
    if (!_btnSkipColor) {
        CGFloat btnWidth = 60;
        CGFloat btnHeight = 30;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _btnSkipColor = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnSkipColor.frame = CGRectMake(screenSize.width - btnWidth - 16, 260, btnWidth, btnHeight);
        [_btnSkipColor setTitle:@"color" forState:UIControlStateNormal];
        [_btnSkipColor setBackgroundColor:[UIColor flatTealColor]];
        [_btnSkipColor addTarget:self action:@selector(onHitBtnSkipColor:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnSkipColor;
}




@end
