//
//  OptionsViewController.m
//  QingDaoQuan
//
//  Created by apple on 14-3-29.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "OptionsViewController.h"

@interface OptionsViewController ()

@end

@implementation OptionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)initializeBarButton {
    
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
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"main_top_noLine"] forBarMetrics:UIBarMetricsDefault];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 89, 22)];
    label.text = @"地图搜索";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:22];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    [self initializeBarButton];
    
}

- (void)leftChoose {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
