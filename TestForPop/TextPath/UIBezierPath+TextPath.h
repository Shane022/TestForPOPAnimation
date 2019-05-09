//
//  UIBezierPath+TextPath.h
//  TestForPop
//
//  Created by Shane on 2019/4/30.
//  Copyright © 2019 Shane. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (TextPath)

+ (UIBezierPath *)bezierPathWithText:(NSString *)text font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
