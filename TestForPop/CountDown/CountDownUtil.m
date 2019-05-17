//
//  CountDownUtil.m
//  TestForPop
//
//  Created by Shane on 2019/5/17.
//  Copyright © 2019 Shane. All rights reserved.
//

#import "CountDownUtil.h"

@interface CountDownUtil ()

@property (nonatomic, copy) dispatch_source_t timer;
@property (nonatomic, strong) NSDateFormatter *dateformatter;


@end

@implementation CountDownUtil

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setDateFormatter];
    }
    
    return self;
}

- (void)setDateFormatter
{
    self.dateformatter = [[NSDateFormatter alloc] init];
    [self.dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (void)countDownWithStartDate:(NSString *)start endDate:(NSString *)end completed:(void (^)(NSInteger, NSInteger, NSInteger, NSInteger))completed
{
    if (_timer == nil) {
        NSDate *startDate = [self.dateformatter dateFromString:start];
        NSDate *endDate = [self.dateformatter dateFromString:end];
        
        NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
        
        if (time == 0) {
            return;
        }
        
        __block NSInteger timeout = time;
        
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
        dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_timer, ^{
            if (timeout <= 0) {
                [self cancelTimer];
                completed(0, 0, 0, 0);
            } else {
                NSInteger days = (NSInteger)(timeout / (3600 * 24));
                NSInteger hours = (NSInteger)((timeout - days * 24 * 3600) / 3600);
                NSInteger minute = (NSInteger)(timeout - days * 24 * 3600 - hours * 3600) / 60;
                NSInteger second = timeout - days * 24 * 3600 - hours * 3600 - minute * 60;
                dispatch_async(dispatch_get_main_queue(), ^{
                    completed(days,hours,minute,second);
                });
                timeout --;
            }
        });
        
        dispatch_resume(_timer);
    }
}

- (void)cancelTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

@end
