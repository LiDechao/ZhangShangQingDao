//
//  MapViewController.h
//  ZhangShangQingDao
//
//  Created by MacBook Pro on 14-5-26.
//  Copyright (c) 2014年 MaFengWo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <IIViewDeckControllerDelegate,CLLocationManagerDelegate,MKMapViewDelegate>

@end
