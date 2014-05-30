//
//  MyAnnotation.h
//  ZhangShangQingDao
//
//  Created by MacBook Pro on 14-5-26.
//  Copyright (c) 2014年 MaFengWo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation>

@property (nonatomic, strong) NSString *myTitle;
@property (nonatomic, strong) NSString *mySubTitle;
@property (nonatomic) CLLocationCoordinate2D myCoordinate;

- (id)initWithTitle:(NSString *)title SubTitle:(NSString *)subTitle Coordinate:(CLLocationCoordinate2D)coordinate ;

@end
