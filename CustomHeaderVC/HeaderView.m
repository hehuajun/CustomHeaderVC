//
//  HeaderView.m
//  CustomHeaderVC
//
//  Created by 何华均 on 2016/10/25.
//  Copyright © 2016年 hhj. All rights reserved.
//

#import "HeaderView.h"
@interface HeaderView()<UIScrollViewDelegate>
{
    NSInteger currentPage;
}
@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)NSTimer *timer;
@end
@implementation HeaderView

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

+ (instancetype)headerView
{
    HeaderView *headerView = [[self alloc]init];
    headerView.scrollView = [[UIScrollView alloc]init];
    headerView.scrollView.pagingEnabled = YES;
    headerView.scrollView.showsHorizontalScrollIndicator = NO;
    headerView.scrollView.delegate = headerView;
    [headerView addSubview:headerView.scrollView];
    
    return headerView;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    CGFloat width = CGRectGetWidth(newSuperview.bounds);
    CGFloat hight = 180;
    self.frame = CGRectMake(0, 0, width, hight);
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake(width*3, hight);
    
    [self addImageViews];
    [self initTimer];
}

- (void)addImageViews
{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat hight = CGRectGetHeight(self.frame);
    for (NSInteger i=0; i<3; i++) {
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(i*width, 0, width, hight)];
        iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",i]];
        [self.scrollView addSubview:iv];
    }
}

- (void)initTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)changeImage
{
    currentPage++;
    if (currentPage>=3) {
        currentPage = 0;
    }
    self.scrollView.contentOffset = CGPointMake(currentPage*CGRectGetWidth(self.frame), 0);
}

#pragma mark- scrollview delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.timer) {
        //停止定时器
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self initTimer];
}

@end
