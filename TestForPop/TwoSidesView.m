//
//  TwoSidesView.m
//  TestForPop
//
//  Created by Shane on 2019/4/19.
//  Copyright © 2019 Shane. All rights reserved.
//

#import "TwoSidesView.h"

@interface TwoSidesView ()

@property (nonatomic, strong) UIImageView *upImageView;
@property (nonatomic, strong) UIImageView *backView;

@end

@implementation TwoSidesView
{
    BOOL _isReverseSide;
    BOOL _isAnimated;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    
    return self;
}

- (void)setupSubViews
{
    _isReverseSide = NO;
    _isAnimated = NO;
    
    // 正面
    [self addSubview:self.upImageView];
    [self bringSubviewToFront:self.upImageView];
    // 反面
    [self addSubview:self.backView];
    [self sendSubviewToBack:self.backView];
}

- (void)startOverturnWithDuration:(NSTimeInterval)duration
{
    if (!self.upImageView || !self.backView) {
        return;
    }
    
    if (_isAnimated) {
        return;
    }
    
    _isAnimated = YES;
    
    if (_isReverseSide) {
        // 反面转正面
        [UIView transitionFromView:self.backView toView:self.upImageView duration:duration options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            self->_isAnimated = NO;
            self->_isReverseSide = NO;
        }];
    } else {
        // 正面转反面
        [UIView transitionFromView:self.upImageView toView:self.backView duration:duration options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            self->_isAnimated = NO;
            self->_isReverseSide = YES;
        }];
    }
}

- (UIImageView *)upImageView
{
    if (!_upImageView) {
        _upImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        UIImage *image = [UIImage imageNamed:@"cover"];
        _upImageView.image = image;
        _upImageView.layer.cornerRadius = self.frame.size.width / 2;
        _upImageView.layer.masksToBounds = YES;
    }
    
    return _upImageView;
}

- (UIImageView *)backView
{
    if (!_backView) {
        _backView = [[UIImageView alloc] initWithFrame:self.bounds];
        UIImage *image = [UIImage imageNamed:@"ad"];
        _backView.image = image;
        _backView.layer.cornerRadius = self.frame.size.width / 2;
        _backView.layer.masksToBounds = YES;
    }
    
    return _backView;
}

@end
