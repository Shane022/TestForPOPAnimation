//
//  NSString+Animation.h
//  TestForPop
//
//  Created by Shane on 2019/4/30.
//  Copyright © 2019 Shane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Animation)

- (void)animateOnView:(UIView *)aView atRect:(CGRect)aRect forFont:(UIFont *)aFont withColor:(UIColor *)aColor andDuration:(CGFloat)aDuration;

@end

NS_ASSUME_NONNULL_END
