//
//  PrimeRateViewController.h
//  QingDaoQuan
//
//  Created by apple on 14-3-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "EGORefreshTableHeaderView.h"

@interface PrimeRateViewController : UIViewController <ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}

@end
