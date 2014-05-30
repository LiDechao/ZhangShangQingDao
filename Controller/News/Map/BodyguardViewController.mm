//
//  BodyguardViewController.m
//  QingDaoQuan
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BodyguardViewController.h"
#import "BaiduMobStat.h"
#import "NewsViewController.h"

@interface BodyguardViewController ()

@end

@implementation BodyguardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//- (void)initializeBarButton {
//    
//    //leftButton
//    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
//    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(-2, 10, 18, 3)];
//    label1.backgroundColor = [UIColor whiteColor];
//    [leftView addSubview:label1];
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(-2, 17, 18, 3)];
//    label2.backgroundColor = [UIColor whiteColor];
//    [leftView addSubview:label2];
//    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(-2, 24, 18, 3)];
//    label3.backgroundColor = [UIColor whiteColor];
//    [leftView addSubview:label3];
//    leftView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftChoose)];
//    [leftView addGestureRecognizer:tap];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
//    self.navigationItem.leftBarButtonItem = leftItem;
//    
//    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 44, 44)];
//    imageView2.image = [UIImage imageNamed:@"commentBtn"];
//    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightChoose)];
//    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
//    rightView.userInteractionEnabled = YES;
//    [rightView addGestureRecognizer:rightTap];
//    rightView.backgroundColor = [UIColor clearColor];
//    [rightView addSubview:imageView2];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
//    self.navigationItem.rightBarButtonItem = rightItem;
//}
- (void)initializaMapView {
    /*
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(36.23, 120.41);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.4, 0.4);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    self.mapView.region = region;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
     */
    self.baiduMapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
    self.baiduMapView.delegate = self;
    self.baiduMapView.userInteractionEnabled = YES;
    [self.view addSubview:self.baiduMapView];
}
#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor greenColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"main_top_noLine"] forBarMetrics:UIBarMetricsDefault];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 89, 22)];
    label.text = @"掌上世园";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:22];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    

    
//    self.baiduMapView.delegate = self;
//    
    [self initializeBarButton];
//    [self initializaMapView];
}
- (void)initializeBarButton {
    //rightButton

    
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

- (void)leftChoose {
//    self.viewDeckController.rightSize = 45;
//    self.viewDeckController.leftSize = 130;
    [self.viewDeckController toggleLeftViewAnimated:YES];
//    [self.viewDeckController closeLeftViewAnimated:NO completion:^(IIViewDeckController *controller, BOOL success) {
//        if (success) {
//            NewsViewController *newVC= [[NewsViewController alloc] init];
//            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:newVC];
//            self.viewDeckController.centerController = nc;
//            self.view.userInteractionEnabled = YES;
//        }
//    }];

}
- (void)rightChoose {
    self.viewDeckController.rightSize = 45;
}
- (BOOL)viewDeckController:(IIViewDeckController *)viewDeckController shouldCloseViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated {
    
    return YES;
}
- (void)viewDidAppear:(BOOL)animated {
    NSString *cName = [NSString stringWithFormat:@"map"];
    [[BaiduMobStat defaultStat] pageviewEndWithName:cName];
}
///*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.baiduMapView.delegate = self;
    
    self.viewDeckController.rightSize = 320;
    self.viewDeckController.leftSize = 320;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.baiduMapView.delegate = nil;
    
    self.viewDeckController.rightSize = 45;
    self.viewDeckController.leftSize = 130;
    
}
// */
@end
