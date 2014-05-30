//
//  GuideViewController.m
//  QingDaoQuan
//
//  Created by apple on 14-3-23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "GuideViewController.h"
#import "AppDelegate.h"

@interface GuideViewController ()

@end

@implementation GuideViewController {
    UIScrollView *_scrollerView;
    NSMutableArray *_dataArray;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)initializeScrollerView {
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"guide1",@"guide2",@"guide3",@"guide4", nil];
    CGRect frame = [UIScreen mainScreen].bounds;
	_scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, 320, frame.size.height-20)];
    _scrollerView.delegate = self;
    for (int i=0; i<_dataArray.count; i++) {
        UIImage *image = [UIImage imageNamed:[_dataArray objectAtIndex:i]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(320*i, 0, 320, frame.size.height-20.0)];
        imageView.image = image;
        [_scrollerView addSubview:imageView];
    }
    _scrollerView.contentSize = CGSizeMake(320*4, frame.size.height-20.0);
    _scrollerView.pagingEnabled = YES;
    _scrollerView.bounces = NO;
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.contentOffset = CGPointMake(0, 0);
    
    [self.view addSubview:_scrollerView];
}
- (void)initDefaultImage {
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.origin.y += 20;
    frame.size.height -= 20;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:@"Default.png"];
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, frame.size.height-100)];
    headImage.image = [UIImage imageNamed:@"DefaultAdd"];
    [imageView addSubview:headImage];
    [self.view addSubview:imageView];
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(nextScroller) userInfo:nil repeats:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self initDefaultImage];
//    [self initializeScrollerView];
    
}
- (void)nextScroller {
    [self initializeScrollerView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.x >= 320*3) {
        [(AppDelegate *)[UIApplication sharedApplication].delegate showRootView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
