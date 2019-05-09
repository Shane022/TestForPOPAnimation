//
//  SingerInfoController.m
//  TestForPop
//
//  Created by Shane on 2019/4/29.
//  Copyright © 2019 Shane. All rights reserved.
//

#import "SingerInfoController.h"
#import <UIView+YYAdd.h>

#define kHEIGHT 198

@interface SingerInfoController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentView;
@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic, copy) void(^listScrollViewScrollBlock)(UIScrollView *scrollView);

@end

@implementation SingerInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
 
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)setupSubviews
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.headerView];

    self.contentView.frame = self.view.frame;
    self.contentView.tableHeaderView = self.headerView;
    
    if (@available(iOS 11.0, *)) {
        self.contentView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.contentView) {
        CGPoint point = scrollView.contentOffset;
        CGFloat offsetY = point.y;
        self.contentView.contentInset = UIEdgeInsetsMake(offsetY, 0, 0, 0);
        
    
        NSLog(@"%lf", offsetY);
    }
}

#pragma mark - <UITableViewDelegate && UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行信息", (long)indexPath.row];
    
    return cell;
}

#pragma mark - Lazy Load
- (UITableView *)contentView
{
    if (!_contentView) {
        _contentView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _contentView.delegate = self;
        _contentView.dataSource = self;
        
//        _contentView.contentInset = UIEdgeInsetsMake(kHEIGHT, 0, 0, 0);
    }
    
    return _contentView;
}

- (UIImageView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 210)];
        _headerView.backgroundColor = [UIColor redColor];
    }
    
    return _headerView;
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

@end
