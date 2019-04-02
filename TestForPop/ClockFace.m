//
//  ClockFace.m
//  TestForPop
//
//  Created by Shane on 2019/4/2.
//  Copyright © 2019 Shane. All rights reserved.
//

#import "ClockFace.h"

@interface ClockFace ()

// 私有属性
@property (nonatomic, strong) CAShapeLayer *hourHand;
@property (nonatomic, strong) CAShapeLayer *minuteHand;
@property (nonatomic, strong) CAShapeLayer *secondHand;

@end

@implementation ClockFace

- (id)init
{
    if ((self = [super init]))
    {
        self.bounds = CGRectMake(0, 0, 200, 200);
        self.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
        self.fillColor = [UIColor whiteColor].CGColor;
        self.strokeColor = [UIColor blackColor].CGColor;
        self.lineWidth = 4;
        
        self.hourHand = [CAShapeLayer layer];
        self.hourHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-2, -70, 4, 70)].CGPath;
        self.hourHand.fillColor = [UIColor blackColor].CGColor;
        self.hourHand.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self addSublayer:self.hourHand];
        
        self.minuteHand = [CAShapeLayer layer];
        self.minuteHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-1, -90, 2, 90)].CGPath;
        self.minuteHand.fillColor = [UIColor blackColor].CGColor;
        self.minuteHand.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self addSublayer:self.minuteHand];
        
        self.secondHand = [CAShapeLayer layer];
        self.secondHand.path = [UIBezierPath bezierPathWithRect:CGRectMake(-2, -95, 1, 95)].CGPath;
        self.secondHand.fillColor = [UIColor redColor].CGColor;
        self.secondHand.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        [self addSublayer:self.secondHand];
        
        [self setupWidgets];
    }
    return self;
}

- (void)setupWidgets
{
    CGFloat positionX = 0;
    CGFloat positionY = 0;
    CGFloat layerWidth = 4;
    CGFloat layerHeight = 12;
    CGFloat tmpWidth = layerWidth;
    CGFloat tmpHeight = layerHeight;
    
    for (NSInteger i = 0; i < 4; i++) {
        if ((i + 1) % 2 == 0) {
            layerWidth = layerHeight;
            layerHeight = tmpWidth;
        } else {
            layerWidth = tmpWidth;
            layerHeight = tmpHeight;
        }

        switch (i) {
            case 0:
            {
                positionX = (self.frame.size.width - layerWidth) / 2;
                positionY = 0;
            }
                break;
            case 1:
            {
                positionX = self.frame.size.width - layerWidth;
                positionY = (self.frame.size.height - layerWidth) / 2;
            }
                break;
            case 2:
            {
                positionX = (self.frame.size.width - layerWidth) / 2;
                positionY = self.frame.size.height - layerHeight;
            }
                break;
            case 3:
            {
                positionX = 0;
                positionY = (self.frame.size.height - layerWidth) / 2;
            }
                break;
            default:
                break;
        }
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = [UIColor blackColor].CGColor;
        layer.path = [UIBezierPath bezierPathWithRect:CGRectMake(positionX, positionY, layerWidth, layerHeight)].CGPath;
        [self addSublayer:layer];
    }
}

- (void)setTime:(NSDate *)time
{
    _time = time;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:time];
    self.hourHand.affineTransform = CGAffineTransformMakeRotation(components.hour / 12.0 * 2.0 * M_PI);
    self.minuteHand.affineTransform = CGAffineTransformMakeRotation(components.minute / 60.0 * 2.0 * M_PI);
    self.secondHand.affineTransform = CGAffineTransformMakeRotation(components.second / 60.0 * 2.0 * M_PI);
}

@end
