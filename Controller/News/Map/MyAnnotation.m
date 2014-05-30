//
//  MyAnnotation.m
//  ZhangShangQingDao
//
//  Created by MacBook Pro on 14-5-26.
//  Copyright (c) 2014年 MaFengWo. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

- (NSString *)title
{
    return self.myTitle;
}

- (NSString *)subtitle
{
    return self.mySubTitle;
}

- (CLLocationCoordinate2D)coordinate
{
    return self.myCoordinate;
}

- (id)initWithTitle:(NSString *)title SubTitle:(NSString *)subTitle Coordinate:(CLLocationCoordinate2D)coordinate
{
    if (self = [super init]) {
        self.myTitle = title;
        self.mySubTitle = subTitle;
        self.myCoordinate = coordinate;
    }
    return self;
}

@end
