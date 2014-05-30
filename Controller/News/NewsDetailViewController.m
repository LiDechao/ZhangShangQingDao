//
//  NewsDetailViewController.m
//  QingDaoQuan
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController {
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
- (void)createBarBut {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-12, 0, 44, 44)];
    imageView.image = [UIImage imageNamed:@"returnBtn"];
    UITapGestureRecognizer *leftTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftChoose)];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    leftView.userInteractionEnabled = YES;
    [leftView addGestureRecognizer:leftTap];
    leftView.backgroundColor = [UIColor clearColor];
    [leftView addSubview:imageView];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 44, 44)];
    imageView2.image = [UIImage imageNamed:@"commentBtn"];
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightChoose)];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    rightView.userInteractionEnabled = YES;
    [rightView addGestureRecognizer:rightTap];
    rightView.backgroundColor = [UIColor clearColor];
    [rightView addSubview:imageView2];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)createWebView {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height-50)];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.webView];
}
- (void)createContView {
    _conView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50, 320, 50)];
    _conView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_conView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 180, 30)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 25)];
    _textField.delegate = self;
    imageView.image = [UIImage imageNamed:@"comment_input"];
    _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField.leftView = imageView;
    _textField.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"txt_background_day"]];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_conView addSubview:_textField];
    
    UIImageView *attentionImg = [[UIImageView alloc] initWithFrame:CGRectMake(220, 10, 30, 30)];
    attentionImg.image = [UIImage imageNamed:@"NOTFavourite"];
    UITapGestureRecognizer *attTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attImgtap)];
    [attentionImg addGestureRecognizer:attTap];
    [_conView addSubview:attentionImg];
    
    UIImageView *shareImg = [[UIImageView alloc] initWithFrame:CGRectMake(270, 10, 30, 30)];
    shareImg.image = [UIImage imageNamed:@"share"];
    UITapGestureRecognizer *shareTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareImgTap)];
    [shareImg addGestureRecognizer:shareTap];
    [_conView addSubview:shareImg];
    
}
- (void)createRequest {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.requestURLStr]];
    [self.webView loadRequest:request];
}
#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.view.backgroundColor = [UIColor grayColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"main_top_bg"] forBarMetrics:UIBarMetricsDefault];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 89, 22)];
    label.text = @"新闻详情";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:22];
    self.navigationItem.titleView = label;
    [self createBarBut];
    [self createWebView];
    [self createContView];
    
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_indicator hidesWhenStopped];
    _indicator.center = CGPointMake(160, 200);
    [self.view addSubview:_indicator];
    
    [self createRequest];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBOardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark - keyBoard
- (void)keyBoardWillShow:(NSNotification *)noti {
    CGSize size = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    CGRect frame = _conView.frame;
    frame.origin.y -= size.height;
    _conView.frame = frame;
    [UIView commitAnimations];
}
- (void)keyBOardWillHide:(NSNotification *)noti {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    _conView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50, 320, 50);
    [UIView commitAnimations];
}
- (void)leftChoose {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)rightChoose {
    
}
- (void)attImgtap {
    
}
- (void)shareImgTap {
    
}
#pragma mark  - webViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [_indicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_indicator stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_indicator stopAnimating];
}
#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_textField resignFirstResponder];
}
@end
