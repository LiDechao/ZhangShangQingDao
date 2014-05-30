//
//  WipeViewController.m
//  QingDaoQuan
//
//  Created by apple on 14-3-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "WipeViewController.h"
#import "IIViewDeckController.h"
#import "QRCodeGenerator.h"
#import <Comment/Comment.h>

@interface WipeViewController ()

@end

@implementation WipeViewController {
    UIImageView *_imageView;
    UIButton *_shareBtn;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"main_top_noLine"] forBarMetrics:UIBarMetricsDefault];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 89, 30)];
//    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"left_ma"]];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"扫码";
    label.font = [UIFont systemFontOfSize:22];
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
    [self wipeStart];
    [self initializeBarButton];
    [self createImageView];
}
- (void)wipeStart {
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
//    ZBarSymbol *symbol = nil;
//    for (symbol in results) {
//        break;
//    }
//    NSLog(@"data=%@", symbol.data);
//    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)createImageView {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    _imageView.center = CGPointMake(160, 240);
    [self.view addSubview:_imageView];
}
- (void)initializeBarButton {
    //rightButton
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 44, 44)];
    imageView.image = [UIImage imageNamed:@"top_right_menu_button"];
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightChoose)];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    rightView.userInteractionEnabled = YES;
    [rightView addGestureRecognizer:rightTap];
    rightView.backgroundColor = [UIColor clearColor];
    [rightView addSubview:imageView];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //leftButton
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(-2, 10, 18, 3)];
    label1.backgroundColor = [UIColor whiteColor];
    [leftView addSubview:label1];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(-2, 17, 18, 3)];
    label2.backgroundColor = [UIColor whiteColor];
    [leftView addSubview:label2];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(-2, 24, 18, 3)];
    label3.backgroundColor = [UIColor whiteColor];
    [leftView addSubview:label3];
    leftView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftChoose)];
    [leftView addGestureRecognizer:tap];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
}
#pragma mark - slideView
- (void)rightChoose {
    _imageView.image = [QRCodeGenerator qrImageForString:@"理工青年" imageSize:_imageView.bounds.size.width];
    
    _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [_shareBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    _shareBtn.frame = CGRectMake(60,self.view.frame.size.height-100, 200,50 );
    [self.view addSubview:_shareBtn];
}

- (void)leftChoose {
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

- (void)buttonClick
{
    id<ISSContent> publishContent = [ShareSDK content:@"我的二维码"
                                       defaultContent:nil
                                                image:[ShareSDK jpegImageWithImage:_imageView.image quality:20]
                                                title:@"我的二维码"
                                                  url:@"http://www.sharesdk.cn"
                                          description:@"二维码"
                                            mediaType:SSPublishContentMediaTypeNews];
    [ShareSDK showShareActionSheet:nil shareList:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        if (state == SSResponseStateSuccess) {
            NSLog(@"分享成功");
        } else if (state == SSResponseStateFail) {
            NSLog(@"分享失败，错误码:%d，错误描述%@",[error errorCode],[error errorDescription]);
        }
    }];
}

@end
