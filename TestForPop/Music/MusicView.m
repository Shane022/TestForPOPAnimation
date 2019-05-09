//
//  MusicView.m
//  TestForPop
//
//  Created by Shane on 2019/4/25.
//  Copyright © 2019 Shane. All rights reserved.
//

#import "MusicView.h"

@implementation MusicView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil].lastObject;
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
