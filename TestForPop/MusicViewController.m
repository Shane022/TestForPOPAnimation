//
//  MusicViewController.m
//  TestForPop
//
//  Created by Shane on 2019/4/23.
//  Copyright © 2019 Shane. All rights reserved.
//

#import "MusicViewController.h"
#import "Chameleon.h"

static NSInteger currentIndex = 1;

@interface MusicViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *musicPlayView;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
}

- (void)setupSubviews
{
    [self.view addSubview:self.musicPlayView];
    [self.view addSubview:self.contentScrollView];
    [self.view addSubview:self.pageControl];
    
    NSArray *arrColors = @[[UIColor flatGreenColor], [UIColor clearColor], [UIColor flatOrangeColor]];
    CGSize scrollViewSize = self.contentScrollView.frame.size;
    NSInteger viewCount = 3;
    
    for (NSInteger i = 0; i < viewCount; i++) {
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(i * scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height)];
        subView.backgroundColor = [arrColors objectAtIndex:i];
        [self.contentScrollView addSubview:subView];
    }
    
    self.contentScrollView.contentSize = CGSizeMake(viewCount * scrollViewSize.width, 0);
    // 默认停留在第2个页面（透明页）
    self.contentScrollView.contentOffset = CGPointMake(currentIndex * scrollViewSize.width, scrollViewSize.height);
    
    self.pageControl.numberOfPages = viewCount;
    self.pageControl.currentPage = currentIndex;
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat screenWidth = scrollView.frame.size.width;
    NSInteger index = scrollView.contentOffset.x / screenWidth;
    self.pageControl.currentPage = index;
}

#pragma mark - Lazy Load

- (UIView *)musicPlayView
{
    if (!_musicPlayView) {
        _musicPlayView = [[UIView alloc] initWithFrame:self.view.bounds];
        _musicPlayView.backgroundColor = [UIColor flatMintColor];
    }
    
    return _musicPlayView;
}

- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        CGFloat scrollViewHeight = 600;
        
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, scrollViewHeight)];
        _contentScrollView.showsVerticalScrollIndicator = NO;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.delegate = self;
    }
    
    return _contentScrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        CGSize scrollViewSize = self.contentScrollView.bounds.size;
        CGFloat pageControlWidth = 160;
        CGFloat pageControlHeight = 44;
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((scrollViewSize.width - pageControlWidth) / 2, scrollViewSize.height - pageControlHeight, pageControlWidth, pageControlHeight)];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor flatGrayColor];
    }
    
    return _pageControl;
}

@end
