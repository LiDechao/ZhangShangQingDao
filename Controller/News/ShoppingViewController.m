//
//  ShoppingViewController.m
//  QingDaoQuan
//
//  Created by apple on 14-3-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ShoppingViewController.h"
#import "IIViewDeckController.h"

@interface ShoppingViewController ()

@end

@implementation ShoppingViewController {
    UIActivityIndicatorView *_indicator;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"main_top_noLine"] forBarMetrics:UIBarMetricsDefault];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 89, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"青报购物";
    label.font = [UIFont systemFontOfSize:22];
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
    [self initializeBarButton];
    [self createWebView];
    [self createWebCont];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_indicator hidesWhenStopped];
    _indicator.center = CGPointMake(160, 200);
    [self.view addSubview:_indicator];
    
    [self createWebRequest];
    
    
}
- (void)createWebRequest {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://shop104470810.m.taobao.com"]];
    [_webView loadRequest:request];
}
- (void)createWebCont {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-44, 320, 44)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.6f;
    [_webView addSubview:view];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 30, 30)];
    imageView.image = [UIImage imageNamed:@"zbar-back"];
    
    [view addSubview:imageView];
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTap)];
    [imageView addGestureRecognizer:leftTap];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 12, 30, 30)];
    imageView2.image = [UIImage imageNamed:@"zbar-back"];
    imageView2.transform = CGAffineTransformMakeRotation(3.14);
    [view addSubview:imageView2];
    
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightTap)];
    [imageView2 addGestureRecognizer:rightTap];
    
    UILabel *refreshLbl = [[UILabel alloc] initWithFrame:CGRectMake(320-30-20, 7, 30, 30)];
    refreshLbl.text = @"○";
    refreshLbl.userInteractionEnabled = YES;
    refreshLbl.font = [UIFont boldSystemFontOfSize:28];
    refreshLbl.textAlignment = NSTextAlignmentCenter;
    refreshLbl.backgroundColor = [UIColor clearColor];
    refreshLbl.textColor = [UIColor whiteColor];
    [view addSubview:refreshLbl];
    UITapGestureRecognizer *refreshTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshTap)];
    [refreshLbl addGestureRecognizer:refreshTap];
}
- (void)leftTap {
    [_webView goBack];
}
- (void)rightTap {
    [_webView goForward];
}
-  (void)refreshTap {
    [_webView reload];
}
- (void)createWebView {
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0,320, [UIScreen mainScreen].bounds.size.height)];
    _webView.backgroundColor = [UIColor grayColor];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
}
- (void)initializeBarButton {
    //leftButton
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(-2, 9, 18, 20)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"<";
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont boldSystemFontOfSize:28];
    [leftView addSubview:label1];
    leftView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftChoose)];
    [leftView addGestureRecognizer:tap];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftItem;
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_indicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_indicator stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_indicator stopAnimating];
}
#pragma mark - slideView
- (void)leftChoose {
    [self.viewDeckController toggleLeftViewAnimated:YES];
}


@end
