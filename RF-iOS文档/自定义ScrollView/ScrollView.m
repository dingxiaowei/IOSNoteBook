

//
//  ScrollView.m
//  IXM
//
//  Created by qianfeng on 14-7-17.
//  Copyright (c) 2014年 qianfeng. All rights reserved.
//

#import "ScrollView.h"

@interface ScrollView ()
{
    UIPageControl * _pageControl;
    NSInteger _count;
}

@end

@implementation ScrollView

- (id)initWithFrame:(CGRect)frame andImageNameArr:(NSArray *)imageNameArr
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化数据
        self.imageNameArr =[NSMutableArray arrayWithArray:imageNameArr];
        _count = 0;
        // 初始化界面
        [self createView];
    }
    return self;
}
-(void)createView
{
    //实例化ScrollView
    self.scroll = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scroll.contentOffset = CGPointMake(0, 0);
    self.scroll.contentSize = CGSizeMake(self.imageNameArr.count * self.scroll.bounds.size.width, self.scroll.bounds.size.height);
    self.scroll.pagingEnabled = YES;
    self.scroll.alwaysBounceHorizontal = YES;
    //给ScrollView添加图片，和单击事件（自定义button）
    for (int i =0;i<self.imageNameArr.count;i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
        [btn setImage:[UIImage imageNamed:[self.imageNameArr objectAtIndex:i]] forState:UIControlStateNormal];
        btn.tag = 3000+i;

        [self.scroll addSubview:btn];
    }
    self.scroll.delegate = self;
    [self addSubview:self.scroll];
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-30 ,self.bounds.size.width, 30)];
    [self addSubview:view];
    [view release];
    view.alpha = 0.4;
    view.backgroundColor = [UIColor blackColor];
    
    //实例化PageControl
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-30, self.bounds.size.width, 30)];
    [self addSubview:_pageControl];
    _pageControl.numberOfPages = self.imageNameArr.count-1;
    _pageControl.currentPage = 0;
    _pageControl.userInteractionEnabled = NO;
    
    //添加个timer自动
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeChanged) userInfo:nil repeats:YES];
}



#pragma mark 实现timer方法
-(void)timeChanged
{
    _count =(int)self.scroll.contentOffset.x/self.bounds.size.width;
    _count++;
    if (_count < 3) {
        _pageControl.currentPage = _count;
        [UIView animateWithDuration:1 animations:^{
            self.scroll.contentOffset = CGPointMake(_count * self.bounds.size.width, 0);
        } completion:nil];
    }
    else if(_count == 3){
        _pageControl.currentPage = 0;
        [self.scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        _count = 0;
    }
}
#pragma mark scroll协议方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //找到偏移量的点
    CGPoint point = self.scroll.contentOffset;
    //找到第几页
    int page = point.x/self.bounds.size.width;
    //给pagecontrol赋值
    _pageControl.currentPage = page;
    //做单项循环滚动
    if (page ==self.imageNameArr.count-1) {
        _pageControl.currentPage = 0;
        self.scroll.contentOffset = CGPointMake(0, 0);
    }
}
#pragma mark dealloc释放属性
-(void)dealloc
{
    self.imageNameArr = nil;
    self.scroll = nil;
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
