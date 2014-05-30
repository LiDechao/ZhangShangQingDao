//
//  CenterViewController.m
//  QingDaoQuan
//
//  Created by apple on 14-3-22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "NewsViewController.h"
#import "IIViewDeckController.h"
#import "UIImageView+WebCache.h"
//#import "ASIHTTPRequest.h"
//#import "LocalView.h"
//#import "PictureView.h"
//#import "HouseView.h"
//#import "LiveView.h"
#import "LocalViewModel.h"
#import "LocalViewCell.h"
#import "PictureViewModel.h"
#import "PictureViewCell.h"
#import "VideoViewModel.h"
#import "NewsDetailViewController.h"

#define SCREEN_FRAME [UIScreen mainScreen].bounds

#define MAINSCRO_ADD(selfView,i,viewName)\
selfView *viewName = [[selfView alloc] initWithFrame:CGRectMake(i*320, 0, 320, SCREEN_FRAME.size.height-20-44-30)];\
[_mainScroller addSubview:viewName];\
[_viewArray addObject:viewName];

#define TABLEVIEW_ADD(tableView,dataArray,i)\
dataArray = [[NSMutableArray alloc] init];\
tableView = [[UITableView alloc] initWithFrame:CGRectMake(320*(i-1), 0, 320,  SCREEN_FRAME.size.height-44) style:UITableViewStylePlain];\
tableView.delegate = self;\
tableView.dataSource = self;\
tableView.tag = i*100;\
tableView.separatorInset = UIEdgeInsetsZero;\
[_mainScroller addSubview:tableView];\
[_viewArray addObject:tableView];\
[_allButArr addObject:dataArray];


@interface NewsViewController ()

@end

@implementation NewsViewController {
    NSArray *_titleArray;//menuBut
    UIView *_menuView;
    ASIHTTPRequest *_requestLocal;
    ASIHTTPRequest *_requestPicture;
    ASIHTTPRequest *_requestInformation;
    ASIHTTPRequest *_requestLive;
    ASIHTTPRequest *_requestHouse;
    ASIHTTPRequest *_requestVideo;
    ASIHTTPRequest *_requestAutoship;
    ASIHTTPRequest *_requestFun;
    ASIHTTPRequest *_requestNews;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - initializa
- (void)initializeBarButton {
    //rightButton
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 44, 44)];
    imageView.image = [UIImage imageNamed:@"top_right_menu_button"];
    UITapGestureRecognizer *rightTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightChoose)];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 44)];
    rightView.userInteractionEnabled = YES;
    [rightView addGestureRecognizer:rightTap];
    rightView.backgroundColor = [UIColor clearColor];
    [rightView addSubview:imageView];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightItem;
    
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
- (void)initializaMenuScroller {
    _titleArray = [[NSArray alloc] initWithObjects:@"本地", @"图片",@"资讯",@"直播",@"房产",@"视频",@"原创",@"娱乐",@"时事",nil];
//    _titleArray = [[NSArray alloc] initWithObjects:@"本地", @"图片",@"资讯",@"直播",@"房产",@"视频",@"原创",@"娱乐",@"时事",@"消费",@"美食",@"旅游",@"健康",@"理财",@"美人",@"婚假",@"亲子",@"教育",@"便民",nil];
    
    _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 33)];
    _menuView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bg"]];
    [self.view addSubview:_menuView];
    //右边的+号
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(274, 0, 320-275, 33)];
    imageView.image = [UIImage imageNamed:@"addbookBtn"];
    [_menuView addSubview:imageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addMene)];
    [imageView addGestureRecognizer:tap];
    //menu菜单
    CGFloat space = 10;
    _menuScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 275, 33)];
    for (int i=0; i<_titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(space+i*(space+40), 0, 40, 33);
        button.tag = i;
        [button setTitle:[_titleArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectMenu:) forControlEvents:UIControlEventTouchUpInside];
        [_menuScroller addSubview:button];
    }
    _menuScroller.contentSize = CGSizeMake(_titleArray.count*(space+40), 33);
    _menuScroller.showsHorizontalScrollIndicator = YES;
    [_menuView addSubview:_menuScroller];
    
    //scroller下划线
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(space, 31, 40, 2)];
    lineLabel.backgroundColor = [UIColor blueColor];
    lineLabel.tag = 100;
    [_menuScroller addSubview:lineLabel];
}
- (void)initializaMainScroller {
    
    _mainScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0,33, 320, SCREEN_FRAME.size.height+20)];
    _mainScroller.delegate = self;
    _mainScroller.pagingEnabled = YES;

    _mainScroller.contentSize = CGSizeMake(320*_viewArray.count, SCREEN_FRAME.size.height-20-44-30);
    [self.view addSubview:_mainScroller];
    
    [self initializaTableView];

}
- (void)initializaTableView {
    _viewArray = [[NSMutableArray alloc] init];//存所有的tableview
//    self.tableView0 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320,  SCREEN_FRAME.size.height-20-44-30) style:UITableViewStylePlain];
//    self.tableView0.delegate = self;
//    self.tableView0.dataSource = self;
//    [_mainScroller addSubview:self.tableView0];
//    [_viewArray addObject:self.tableView0];

    TABLEVIEW_ADD(self.tableView1,self.dataArray1, 1);
    [self tableView1ScrollerView];
    [_allButArr addObject:self.dataArray1];
//    NSLog(@"arr1===%@",[_allButArr objectAtIndex:0]);
    TABLEVIEW_ADD(self.tableView2,self.dataArray2, 2);
    TABLEVIEW_ADD(self.tableView3,self.dataArray3, 3);
    TABLEVIEW_ADD(self.tableView4,self.dataArray4, 4);
    TABLEVIEW_ADD(self.tableView5, self.dataArray5, 5);
    TABLEVIEW_ADD(self.tableView6, self.dataArray6, 6);
    TABLEVIEW_ADD(self.tableView7, self.dataArray7, 7);
    TABLEVIEW_ADD(self.tableView8, self.dataArray8, 8);
    TABLEVIEW_ADD(self.tableView9, self.dataArray9, 9);
    
}
- (void)tableView1ScrollerView {
    scrollerPage = 0;
    self.scrollerImgArr = [[NSMutableArray alloc] init];
    self.scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320*4, 175)];
    self.scrollerView.contentSize = CGSizeMake(320*4, 100);
    self.scrollerView.showsVerticalScrollIndicator = NO;
    self.scrollerView.bounces = NO;
    self.scrollerView.backgroundColor = [UIColor yellowColor];
    self.scrollerView.pagingEnabled = YES;
    self.scrollerView.tag = 888;
    self.scrollerView.delegate = self;
    [self.tableView1 setTableHeaderView:self.scrollerView];
    
    self.menuPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(230,175-30+2, 80, 25)];
    self.menuPageControl.numberOfPages = 4;
    self.menuPageControl.currentPage = 0;
    [self.menuPageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    self.menuPageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    [self.tableView1 addSubview:self.menuPageControl];
    
    self.sView = [[UIView alloc] initWithFrame:CGRectMake(0, 175-30, 320, 30)];
    self.sView.backgroundColor = [UIColor blackColor];
    self.sView.alpha = 0.4f;
    [self.scrollerView addSubview:self.sView];
    
    self.sLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 160, 25)];
    self.sLabel.textColor = [UIColor whiteColor];
    [self.sView addSubview:self.sLabel];
    
}
- (void)pageChange:(UIPageControl *)pageController {
    _menuScroller.contentOffset = CGPointMake(pageController.currentPage, 0);
}

#pragma mark - ASIHTTPRequest
- (void)createRequest:(NSString *)catTitle {
    if ([catTitle isEqualToString:@"本地"]) {
        NSString *str = [catTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _requestLocal = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zsqd.qdqss.cn/new/posts.ashx?page=1&action=list&category=%@",str]]];
        _requestLocal.tag = [_titleArray indexOfObject:catTitle]+1;
        _requestLocal.delegate = self;
        [_requestLocal startAsynchronous];
    } else if ([catTitle isEqualToString:@"图片"]) {
        NSString *str = [catTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _requestPicture = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zsqd.qdqss.cn/new/posts.ashx?page=1&action=list&category=%@",str]]];
        _requestPicture.tag = [_titleArray indexOfObject:catTitle]+1;
        _requestPicture.delegate = self;
        [_requestPicture startAsynchronous];
    } else if ([catTitle isEqualToString:@"资讯"]) {
        NSString *str = [catTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _requestInformation = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zsqd.qdqss.cn/new/posts.ashx?page=1&action=list&category=%@",str]]];
        _requestInformation.tag = [_titleArray indexOfObject:catTitle]+1;
        _requestInformation.delegate = self;
        [_requestInformation startAsynchronous];
    } else if ([catTitle isEqualToString:@"直播"]) {
        NSString *str = [catTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _requestLive = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zsqd.qdqss.cn/new/posts.ashx?page=1&action=list&category=%@",str]]];
        _requestLive.tag = [_titleArray indexOfObject:catTitle]+1;
        _requestLive.delegate = self;
        [_requestLive startAsynchronous];
    } else if ([catTitle isEqualToString:@"房产"]) {
        NSString *str = [catTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _requestHouse = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zsqd.qdqss.cn/new/posts.ashx?page=1&action=list&category=%@",str]]];
        _requestHouse.tag = [_titleArray indexOfObject:catTitle]+1;
        _requestHouse.delegate = self;
        [_requestHouse startAsynchronous];
    } else if ([catTitle isEqualToString:@"视频"]) {
        NSString *str = [catTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _requestVideo = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zsqd.qdqss.cn/new/posts.ashx?page=1&action=list&category=%@",str]]];
        _requestVideo.tag = [_titleArray indexOfObject:catTitle]+1;
        _requestVideo.delegate = self;
        [_requestVideo startAsynchronous];
    } else if ([catTitle isEqualToString:@"原创"]) {
        NSString *str = [catTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _requestAutoship = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zsqd.qdqss.cn/new/posts.ashx?page=1&action=list&category=%@",str]]];
        _requestAutoship.tag = [_titleArray indexOfObject:catTitle]+1;
        _requestAutoship.delegate = self;
        [_requestAutoship startAsynchronous];
    } else if ([catTitle isEqualToString:@"娱乐"]) {
        NSString *str = [catTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _requestFun = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zsqd.qdqss.cn/new/posts.ashx?page=1&action=list&category=%@",str]]];
        _requestFun.tag = [_titleArray indexOfObject:catTitle]+1;
        _requestFun.delegate = self;
        [_requestFun startAsynchronous];
    } else if ([catTitle isEqualToString:@"时事"]) {
        NSString *str = [catTitle stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        _requestNews = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zsqd.qdqss.cn/new/posts.ashx?page=1&action=list&category=%@",str]]];
        _requestNews.tag = [_titleArray indexOfObject:catTitle]+1;
        _requestNews.delegate = self;
        [_requestNews startAsynchronous];
    }
    
}
- (void)requestFinished:(ASIHTTPRequest *)request {
    if (request.tag == 1) {
//        NSLog(@"11++%@",self.dataArray1);
        
        NSArray *dataArr = [[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"data"];
        for (NSDictionary *dict in dataArr) {
            LocalViewModel *model = [[LocalViewModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray1 addObject:model];
            
//            if ([model.post_hd isEqualToString:@"1"]) {
//                UIImage *image = [UIImage im]
//                [imageView setImage:[NSURL URLWithString:model.item_small_pic]];
//                [_scrollerImgArr addObject:imageView];
//            }
        }
//        NSLog(@"22++%@",self.dataArray1);
//        NSArray *arr = [_allButArr objectAtIndex:1];
//        NSLog(@"%@",arr);
//        [_allButArr replaceObjectAtIndex:[_allButArr indexOfObject:self.dataArray1] withObject:self.dataArray1];
//        arr = [_allButArr objectAtIndex:1];
//        NSLog(@"%@",arr);
        [self.tableView1 reloadData];
    }
    if (request.tag == 2) {
        NSArray *dataArr = [[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"data"];
        for (NSDictionary *dict in dataArr) {
            PictureViewModel *model = [[PictureViewModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray2 addObject:model];
        }
        [_allButArr replaceObjectAtIndex:[_allButArr indexOfObject:self.dataArray2] withObject:self.dataArray2];
        [self.tableView2 reloadData];
    }
    if (request.tag == 3) {
        NSArray *dataArr = [[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"data"];
        for (NSDictionary *dict in dataArr) {
            LocalViewModel *model = [[LocalViewModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray3 addObject:model];
        }
        [_allButArr replaceObjectAtIndex:[_allButArr indexOfObject:self.dataArray3] withObject:self.dataArray3];
        [self.tableView3 reloadData];
    }
    if (request.tag == 4) {
        NSArray *dataArr = [[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"data"];
        for (NSDictionary *dict in dataArr) {
            LocalViewModel *model = [[LocalViewModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray4 addObject:model];
        }
        [_allButArr replaceObjectAtIndex:[_allButArr indexOfObject:self.dataArray4] withObject:self.dataArray4];
        [self.tableView4 reloadData];
    }
    if (request.tag == 5) {
        NSArray *dataArr = [[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"data"];
        for (NSDictionary *dict in dataArr) {
            LocalViewModel *model = [[LocalViewModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray5 addObject:model];
        }

        [_allButArr replaceObjectAtIndex:[_allButArr indexOfObject:self.dataArray5] withObject:self.dataArray5];
        [self.tableView5 reloadData];
    }
    if (request.tag == 6) {
        NSArray *dataArr = [[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"data"];
        for (NSDictionary *dict in dataArr) {
            VideoViewModel *model = [[VideoViewModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray6 addObject:model];
        }
        
        [_allButArr replaceObjectAtIndex:[_allButArr indexOfObject:self.dataArray6] withObject:self.dataArray6];
        [self.tableView6 reloadData];
    }
    if (request.tag == 7) {
        NSArray *dataArr = [[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"data"];
        for (NSDictionary *dict in dataArr) {
            LocalViewModel *model = [[LocalViewModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray7 addObject:model];
        }
        
        [_allButArr replaceObjectAtIndex:[_allButArr indexOfObject:self.dataArray7] withObject:self.dataArray7];
        [self.tableView7 reloadData];
    }
    if (request.tag == 8) {
        NSArray *dataArr = [[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"data"];
        for (NSDictionary *dict in dataArr) {
            LocalViewModel *model = [[LocalViewModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray8 addObject:model];
        }
        
        [_allButArr replaceObjectAtIndex:[_allButArr indexOfObject:self.dataArray8] withObject:self.dataArray8];
        [self.tableView8 reloadData];
    }
    if (request.tag == 9) {
        NSArray *dataArr = [[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"data"];
        for (NSDictionary *dict in dataArr) {
            LocalViewModel *model = [[LocalViewModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray9 addObject:model];
        }
        
        [_allButArr replaceObjectAtIndex:[_allButArr indexOfObject:self.dataArray9] withObject:self.dataArray9];
        [self.tableView9 reloadData];
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request {
    
}
#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"main_top_bg"] forBarMetrics:UIBarMetricsDefault];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 89, 22)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"logo"]];
    self.navigationItem.titleView = label;
    
    [self initializeBarButton];
    [self initializaMenuScroller];
    [self initializaMainScroller];
    
    _requestLocal = [[ASIHTTPRequest alloc] init];
    _requestPicture = [[ASIHTTPRequest alloc] init];
    _requestInformation = [[ASIHTTPRequest alloc] init];
    _requestLive = [[ASIHTTPRequest alloc] init];
    _requestHouse = [[ASIHTTPRequest alloc] init];
    _requestVideo = [[ASIHTTPRequest alloc] init];
    _requestAutoship = [[ASIHTTPRequest alloc] init];
    _requestFun = [[ASIHTTPRequest alloc] init];
    _requestNews = [[ASIHTTPRequest alloc] init];
    
    [self createRequest:@"本地"];
    
}
#pragma mark - tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView1) {
        LocalViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LocalViewCell" owner:self options:0] lastObject];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"news_cell_background_day"]];
        }
        if (self.dataArray1.count == 0) {
            return cell;
        }
        LocalViewModel *model = [self.dataArray1 objectAtIndex:indexPath.row];
        cell.newsTitle.text = model.post_title;
        cell.newsContent.text = model.post_content;
        [cell.newsImage setImageWithURL:[NSURL URLWithString:model.item_small_pic] placeholderImage:[UIImage imageNamed:@"loading_160x60"]];
        
        if ([model.post_hd boolValue]) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(320*scrollerPage, 0, 320, 175)];
            
            [imageView setImageWithURL:[NSURL URLWithString:model.item_small_pic]];
            [self.scrollerView addSubview:imageView];
            
            UIView *ssview = [[UIView alloc] initWithFrame:CGRectMake(320*scrollerPage, 175-30, 320, 30)];
            ssview.backgroundColor = [UIColor blackColor];
            ssview.alpha = 0.4f;
            [self.scrollerView addSubview:ssview];
            
            UILabel *sslabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 230, 25)];
            sslabel.textColor = [UIColor whiteColor];
            sslabel.text = model.post_title;
            [ssview addSubview:sslabel];
            scrollerPage++;
        }
        return cell;
    }
    if (tableView == self.tableView2) {
        PictureViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID2"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PictureViewCell" owner:self options:0] lastObject];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"news_cell_background_day"]];
        }
        if (self.dataArray2.count == 0) {
            return cell;
        }
        PictureViewModel *model = [self.dataArray2 objectAtIndex:indexPath.row];
        cell.titleLbl.text = model.post_title;
        [cell.contentImg setImageWithURL:[NSURL URLWithString:model.item_small_pic] placeholderImage:[UIImage imageNamed:@"loading_240x180"]];
        return cell;
    }
    if (tableView == self.tableView3) {
        LocalViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LocalViewCell" owner:self options:0] lastObject];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"news_cell_background_day"]];
        }
        if (self.dataArray3.count == 0) {
            return cell;
        }
        LocalViewModel *model = [self.dataArray3 objectAtIndex:indexPath.row];
        cell.newsTitle.text = model.post_title;
        cell.newsContent.text = model.post_content;
        [cell.newsImage setImageWithURL:[NSURL URLWithString:model.item_small_pic] placeholderImage:[UIImage imageNamed:@"loading_160x60"]];
        return cell;
    }
    if (tableView == self.tableView4) {
        LocalViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LocalViewCell" owner:self options:0] lastObject];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"news_cell_background_day"]];
        }
        if (self.dataArray4.count == 0) {
            return cell;
        }
        LocalViewModel *model = [self.dataArray4 objectAtIndex:indexPath.row];
        cell.newsTitle.text = model.post_title;
        cell.newsContent.text = model.post_content;
        [cell.newsImage setImageWithURL:[NSURL URLWithString:model.item_small_pic] placeholderImage:[UIImage imageNamed:@"loading_160x60"]];
        return cell;
    }
    if (tableView == self.tableView5) {
        LocalViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LocalViewCell" owner:self options:0] lastObject];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"news_cell_background_day"]];
        }
        if (self.dataArray5.count == 0) {
            return cell;
        }
        LocalViewModel *model = [self.dataArray5 objectAtIndex:indexPath.row];
        cell.newsTitle.text = model.post_title;
        cell.newsContent.text = model.post_content;
        [cell.newsImage setImageWithURL:[NSURL URLWithString:model.item_small_pic] placeholderImage:[UIImage imageNamed:@"loading_160x60"]];
        return cell;
    }
    if (tableView == self.tableView6) {
        LocalViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LocalViewCell" owner:self options:0] lastObject];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"news_cell_background_day"]];
        }
        if (self.dataArray6.count == 0) {
            return cell;
        }
        VideoViewModel *model = [self.dataArray6 objectAtIndex:indexPath.row];
        cell.newsTitle.text = model.post_title;
        cell.newsContent.text = model.post_content;
        [cell.newsImage setImageWithURL:[NSURL URLWithString:model.item_small_pic] placeholderImage:[UIImage imageNamed:@"loading_160x60"]];
        return cell;
    }
    if (tableView == self.tableView7) {
        LocalViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LocalViewCell" owner:self options:0] lastObject];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"news_cell_background_day"]];
        }
        if (self.dataArray7.count == 0) {
            return cell;
        }
        LocalViewModel *model = [self.dataArray7 objectAtIndex:indexPath.row];
        cell.newsTitle.text = model.post_title;
        cell.newsContent.text = model.post_content;
        [cell.newsImage setImageWithURL:[NSURL URLWithString:model.item_small_pic] placeholderImage:[UIImage imageNamed:@"loading_160x60"]];
        return cell;
    }
    if (tableView == self.tableView8) {
        LocalViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LocalViewCell" owner:self options:0] lastObject];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"news_cell_background_day"]];
        }
        if (self.dataArray8.count == 0) {
            return cell;
        }
        LocalViewModel *model = [self.dataArray8 objectAtIndex:indexPath.row];
        cell.newsTitle.text = model.post_title;
        cell.newsContent.text = model.post_content;
        [cell.newsImage setImageWithURL:[NSURL URLWithString:model.item_small_pic] placeholderImage:[UIImage imageNamed:@"loading_160x60"]];
        return cell;
    }
    if (tableView == self.tableView9) {
        LocalViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID1"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LocalViewCell" owner:self options:0] lastObject];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"news_cell_background_day"]];
        }
        if (self.dataArray9.count == 0) {
            return cell;
        }
        LocalViewModel *model = [self.dataArray9 objectAtIndex:indexPath.row];
        cell.newsTitle.text = model.post_title;
        cell.newsContent.text = model.post_content;
        [cell.newsImage setImageWithURL:[NSURL URLWithString:model.item_small_pic] placeholderImage:[UIImage imageNamed:@"loading_160x60"]];
        return cell;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (tableView.tag) {
        case 100:
            return self.dataArray1.count;
        case 200:
            return self.dataArray2.count;
        case 300:
            return self.dataArray3.count;
        case 400:
            return self.dataArray4.count;
        case 500:
            return self.dataArray5.count;
        case 600:
            return self.dataArray6.count;
        case 700:
            return self.dataArray7.count;
        case 800:
            return self.dataArray8.count;
        case 900:
            return self.dataArray9.count;
        default:
            break;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (tableView.tag) {
        case 100:
            return 70.0;
        case 200:
            return 210.0;
        case 300:
            return 70.0;
        case 400:
            return 70.0;
        case 500:
            return 70.0;
        case 600:
            return 70.0;
        case 700:
            return 70.0;
        case 800:
            return 70.0;
        case 900:
            return 70.0;
        default:
            break;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsDetailViewController *nvc = [[NewsDetailViewController alloc] init];
    
    if (tableView.tag==100 ) {
        LocalViewModel *model = [_dataArray1 objectAtIndex:indexPath.row];
        nvc.requestURLStr = model.post_link;
    } else if (tableView.tag == 200) {
        PictureViewModel *model = [_dataArray2 objectAtIndex:indexPath.row];
        nvc.requestURLStr = model.post_link;
    } else if (tableView.tag == 300) {
        LocalViewModel *model = [_dataArray3 objectAtIndex:indexPath.row];
        nvc.requestURLStr = model.post_link;
    } else if (tableView.tag == 400) {
        LocalViewModel *model = [_dataArray4 objectAtIndex:indexPath.row];
        nvc.requestURLStr = model.post_link;
    } else if (tableView.tag == 500) {
        LocalViewModel *model = [_dataArray5 objectAtIndex:indexPath.row];
        nvc.requestURLStr = model.post_link;
    } else if (tableView.tag == 600) {
        VideoViewModel *model = [_dataArray6 objectAtIndex:indexPath.row];
        nvc.requestURLStr = model.post_link;
    } else if (tableView.tag == 700) {
        LocalViewModel *model = [_dataArray7 objectAtIndex:indexPath.row];
        nvc.requestURLStr = model.post_link;
    } else if (tableView.tag == 800) {
        LocalViewModel *model = [_dataArray8 objectAtIndex:indexPath.row];
        nvc.requestURLStr = model.post_link;
    } else if (tableView.tag == 900) {
        LocalViewModel *model = [_dataArray9 objectAtIndex:indexPath.row];
        nvc.requestURLStr = model.post_link;
    }
    [self.navigationController pushViewController:nvc animated:YES];
    
}

#pragma mark - scrollerViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.tag != 888) {
        if (_mainScroller.contentOffset.x <= 10) {
            //        [self.viewDeckController toggleLeftViewAnimated:YES];
        } else if (_mainScroller.contentOffset.x >= (_viewArray.count-1)*320+10) {
            //        [self.viewDeckController toggleRightViewAnimated:YES];
        }
    }
    
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.tag != 888) {
        [self.viewDeckController closeLeftViewAnimated:YES];
        [self.viewDeckController closeRightViewAnimated:YES];
        butTag = scrollView.contentOffset.x/320;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag != 888) {
        int buttonTag = scrollView.contentOffset.x/320;
        CGFloat space = 10;
        if (scrollView.contentOffset.y == 0) {
        
            [UIView beginAnimations:NULL context:nil];
            [UIView setAnimationDuration:0.2f];
            CGRect frame = [_menuView viewWithTag:100].frame;
            frame.origin.x = space+buttonTag*(space+40);
            [_menuView viewWithTag:100].frame = frame;
            [UIView commitAnimations];
        }
        
        //增加刷新事件
        if (butTag != buttonTag) {
            if (buttonTag == 0) {
                [self createRequest:@"本地"];
            } else {
                UIButton *button = (UIButton *)[_menuScroller viewWithTag:buttonTag];
                [self createRequest:button.titleLabel.text];
            }
        }
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.scrollerView) {
        self.menuPageControl.currentPage = scrollView.contentOffset.x/320;
    }
}
#pragma mark - selectMenu
- (void)selectMenu:(UIButton *)button {
    [self.viewDeckController closeLeftViewAnimated:YES];
    [self.viewDeckController closeRightViewAnimated:YES];
    NSArray *arr = [_allButArr objectAtIndex:button.tag];
    if (arr.count == 0) {
        [self createRequest:button.titleLabel.text];
    }
    
    CGFloat space = 10;
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDuration:0.2f];
    CGRect frame = [_menuView viewWithTag:100].frame;
    frame.origin.x = space+button.tag*(space+40);
    [_menuView viewWithTag:100].frame = frame;
    [UIView commitAnimations];
    _mainScroller.contentOffset = CGPointMake(320*button.tag, 0);

}

#pragma mark - slideView
- (void)rightChoose {
    [self.viewDeckController toggleRightViewAnimated:YES];
}
- (void)leftChoose {
    [self.viewDeckController toggleLeftViewAnimated:YES];
}
#pragma mark - addMene
- (void)addMene {
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [_requestLocal clearDelegatesAndCancel];
    [_requestPicture clearDelegatesAndCancel];
    [_requestInformation clearDelegatesAndCancel];
    [_requestLive clearDelegatesAndCancel];
    [_requestHouse clearDelegatesAndCancel];
    [_requestVideo clearDelegatesAndCancel];
    [_requestFun clearDelegatesAndCancel];
    [_requestNews clearDelegatesAndCancel];
}

@end
