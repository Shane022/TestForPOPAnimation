//
//  CountDownUtil.h
//  TestForPop
//
//  Created by Shane on 2019/5/17.
//  Copyright © 2019 Shane. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountDownUtil : NSObject

- (void)countDownWithStartDate:(NSString *)start endDate:(NSString *)end completed:(void (^)(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second))completed;
- (void)cancelTimer;

@end

NS_ASSUME_NONNULL_END
