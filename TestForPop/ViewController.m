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

@interface ViewController ()

@property (nonatomic, strong) UIView *baseView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) ClockFace *clockFace;
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self.view addSubview:self.baseView];
//    [self testForPopAnimation];
    
    [self testForClock];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopAction:nil];
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


@end
