//
//  ClockFace.h
//  TestForPop
//
//  Created by Shane on 2019/4/2.
//  Copyright © 2019 Shane. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClockFace : CAShapeLayer

@property (nonatomic, strong) NSDate *time;

@end

NS_ASSUME_NONNULL_END
