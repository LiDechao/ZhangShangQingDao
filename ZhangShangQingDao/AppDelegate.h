//
//  AppDelegate.h
//  QingDaoQuan
//
//  Created by apple on 14-3-22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "BMKMapManager.h"
#import "BMapKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) BMKMapManager *mapManager;

- (void)showRootView;

@end
