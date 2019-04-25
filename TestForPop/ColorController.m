//
//  ColorController.m
//  TestForPop
//
//  Created by Shane on 2019/4/24.
//  Copyright © 2019 Shane. All rights reserved.
//

#import "ColorController.h"
#import <ChameleonFramework/Chameleon.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface ColorController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *colorScrollView;
@property (nonatomic, strong) UIButton *btnStart;

@end

@implementation ColorController
{
    NSArray *_arrColors;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)setupSubviews
{
    _arrColors = [NSArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.colorScrollView];
    [self.view addSubview:self.btnStart];
}

- (void)setColors
{
    NSLog(@"%@", _arrColors);

    if (_arrColors && _arrColors.count > 0) {
        NSArray *arrTmp = [_arrColors copy];

        CGSize scrollViewSize = self.colorScrollView.bounds.size;
        CGFloat topGap = 10;
        CGFloat leftGap = 8;
        CGFloat colorViewWidth = scrollViewSize.height - 2 * topGap;
        CGFloat colorViewHeight = colorViewWidth;
        CGFloat colorViewGap = 10;
        
        for (NSInteger i = 0; i < arrTmp.count; i++) {
            UIView *colorView = [[UIView alloc] init];
            colorView.frame = CGRectMake(leftGap + (colorViewGap + colorViewWidth) * i, topGap, colorViewWidth, colorViewHeight);
            UIColor *color = [arrTmp objectAtIndex:i];
            colorView.backgroundColor = color;
            
            [self.colorScrollView addSubview:colorView];
        }
        
        [self.colorScrollView setContentSize:CGSizeMake(leftGap * 2 + colorViewGap * (arrTmp.count - 1) + colorViewWidth * arrTmp.count, 0)];
    }

}

- (void)onHitBtnStart:(UIButton *)btn
{
    _arrColors = [NSArray arrayOfColorsFromImage:self.imageView.image withFlatScheme:YES];
    
    [self setColors];
}

#pragma mark - Lazy Load

- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImage *image = [UIImage imageNamed:@"ad"];
        CGFloat imageViewWidth = 300;
        CGFloat imageViewHeight = 300;
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake((screenSize.width - imageViewWidth) / 2, 140, imageViewWidth, imageViewHeight)];
        _imageView.image = image;
    }
    
    return _imageView;
}

- (UIScrollView *)colorScrollView
{
    if (!_colorScrollView) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        _colorScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 40, screenSize.width, 100)];
        _colorScrollView.backgroundColor = [UIColor flatWhiteColor];
    }
    
    return _colorScrollView;
}

- (UIButton *)btnStart
{
    if (!_btnStart) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        CGFloat btnWidth = 120;
        CGFloat btnHeight = 30;
        
        _btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnStart.frame = CGRectMake((size.width - btnWidth) / 2, CGRectGetMaxY(self.colorScrollView.frame) + 40, btnWidth, btnHeight);
        [_btnStart setTitle:@"start" forState:UIControlStateNormal];
        [_btnStart setTitleColor:[UIColor flatWhiteColor] forState:UIControlStateNormal];
        [_btnStart setBackgroundColor:[UIColor flatOrangeColor]];
        [_btnStart addTarget:self action:@selector(onHitBtnStart:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnStart;
}

@end
