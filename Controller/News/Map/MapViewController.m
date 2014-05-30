//
//  MapViewController.m
//  ZhangShangQingDao
//
//  Created by MacBook Pro on 14-5-26.
//  Copyright (c) 2014年 MaFengWo. All rights reserved.
//

#import "MapViewController.h"
#import "MyAnnotation.h"

@interface MapViewController ()

@property (nonatomic, strong) MKMapView *myMapView;

@end

@implementation MapViewController

@synthesize myMapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"main_top_noLine"] forBarMetrics:UIBarMetricsDefault];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 89, 22)];
    label.text = @"地图搜索";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:22];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    [self initializeBarButton];
    [self initMapView];
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
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

- (void)initMapView
{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(36.10, 120.39);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.2, 0.2);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    
    myMapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    myMapView.region = region;
    myMapView.delegate = self;
    myMapView.showsUserLocation = YES;
    [self.view addSubview:myMapView];
    
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    manager.distanceFilter = 10;
    manager.delegate = self;
    [manager startUpdatingLocation];
    
    //添加大头针
    MyAnnotation *anno = [[MyAnnotation alloc] initWithTitle:@"大头针" SubTitle:@"beautiful" Coordinate:coordinate];
    [myMapView addAnnotation:anno];
    
    //手势长按添加大头针
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [myMapView addGestureRecognizer:longPress];
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress
{
    CGPoint point = [longPress locationInView:myMapView];
    if (longPress.state == UIGestureRecognizerStateBegan) {
        CLLocationCoordinate2D coordinate = [myMapView convertPoint:point toCoordinateFromView:myMapView];
        MyAnnotation *anno = [[MyAnnotation alloc] initWithTitle:@"title" SubTitle:@"subtitle" Coordinate:coordinate];
        [myMapView addAnnotation:anno];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.2, 0.2);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [myMapView setRegion:region animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[mapView.userLocation class]]) {
        return nil;
    }
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ID"];
    }
    //动画
    pinView.animatesDrop = YES;
    //颜色
    pinView.pinColor = MKPinAnnotationColorPurple;
    //详情
    pinView.canShowCallout = YES;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pinView.rightCalloutAccessoryView = rightBtn;
    
    return pinView;
}
















@end
