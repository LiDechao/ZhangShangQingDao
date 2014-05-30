//
//  BodyguardViewController.h
//  QingDaoQuan
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "BMKMapView.h"
#import "BMapKit.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface BodyguardViewController : UIViewController <BMKMapViewDelegate,IIViewDeckControllerDelegate,MKMapViewDelegate>

@property (nonatomic,retain) MKMapView *mapView;
@property (nonatomic,retain) BMKMapView *baiduMapView;

@end
