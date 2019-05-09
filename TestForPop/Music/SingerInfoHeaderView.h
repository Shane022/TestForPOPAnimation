//
//  SingerInfoHeaderView.h
//  TestForPop
//
//  Created by Shane on 2019/4/29.
//  Copyright © 2019 Shane. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface SingerInfoHeaderView : UIView

@property (nonatomic, strong) UIImageView *headerImageView;

- (void)updateFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
