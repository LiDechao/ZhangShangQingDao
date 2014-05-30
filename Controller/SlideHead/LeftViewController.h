//
//  LeftViewController.h
//  QingDaoQuan
//
//  Created by apple on 14-3-22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
    NSArray *_dataArray;
}


@end
