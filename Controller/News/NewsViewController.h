//
//  CenterViewController.h
//  QingDaoQuan
//
//  Created by apple on 14-3-22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface NewsViewController : UIViewController <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,UIScrollViewDelegate> {
    UIScrollView *_menuScroller;
    UIScrollView *_mainScroller;
    NSMutableArray *_viewArray; //存所有的tableView
    NSDictionary *_buttonView;
    int butTag;//暂存but的tag
    NSMutableArray *_allButArr;//存所有的dataArray
    int scrollerPage;
}

@property (nonatomic, retain) UITableView *tableView1;
@property (nonatomic, retain) NSMutableArray *dataArray1;

@property (nonatomic,retain) UIScrollView *scrollerView;
@property (nonatomic,retain) UIPageControl *menuPageControl;
@property (nonatomic,retain) UIView *sView;
@property (nonatomic,retain) UILabel *sLabel;
@property (nonatomic,retain) NSMutableArray *scrollerImgArr;
@property (nonatomic, retain) UITableView *tableView2;
@property (nonatomic, retain) NSMutableArray *dataArray2;

@property (nonatomic, retain) UITableView *tableView3;
@property (nonatomic, retain) NSMutableArray *dataArray3;

@property (nonatomic, retain) UITableView *tableView4;
@property (nonatomic, retain) NSMutableArray *dataArray4;

@property (nonatomic, retain) UITableView *tableView5;
@property (nonatomic, retain) NSMutableArray *dataArray5;

@property (nonatomic, retain) UITableView *tableView6;
@property (nonatomic, retain) NSMutableArray *dataArray6;

@property (nonatomic, retain) UITableView *tableView7;
@property (nonatomic, retain) NSMutableArray *dataArray7;

@property (nonatomic, retain) UITableView *tableView8;
@property (nonatomic, retain) NSMutableArray *dataArray8;

@property (nonatomic, retain) UITableView *tableView9;
@property (nonatomic, retain) NSMutableArray *dataArray9;


@end
