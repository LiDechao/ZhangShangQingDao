//
//  PrimeRateViewController.m
//  QingDaoQuan
//
//  Created by apple on 14-3-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "PrimeRateViewController.h"
#import "IIViewDeckController.h"
#import "LocalViewModel.h"
#import "PictureViewCell.h"
#import "UIImageView+WebCache.h"

@interface PrimeRateViewController ()

@end

@implementation PrimeRateViewController {
    ASIHTTPRequest *_request;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)createTableView {
    _dataArray = [[NSMutableArray alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:_tableView];
}
- (void)crateRequest {
    NSString *str = [@"优惠券" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _request  = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://zsqd.qdqss.cn/new/posts.ashx?page=1&action=list&category=%@",str]]];
    _request.delegate = self;
    [_request startAsynchronous];
}
#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"main_top_noLine"] forBarMetrics:UIBarMetricsDefault];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 89, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"优惠";
    label.font = [UIFont systemFontOfSize:22];
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
    [self initializeBarButton];
    [self createTableView];
    [self crateRequest];
}

- (void)initializeBarButton {
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
#pragma mark - ASIHTTPRequest
- (void)requestFinished:(ASIHTTPRequest *)request {
    NSArray *dataArr = [[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"data"];
    for (NSDictionary *dict in dataArr) {
        LocalViewModel *model = [[LocalViewModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [_dataArray addObject:model];
    }
    [_tableView reloadData];
}
- (void)requestFailed:(ASIHTTPRequest *)request {
    
}
#pragma mark - tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PictureViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID2"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PictureViewCell" owner:self options:0] lastObject];
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"news_cell_background_day"]];
    }
    if (_dataArray.count == 0) {
        return cell;
    }
    LocalViewModel *model = [_dataArray objectAtIndex:indexPath.row];
    cell.titleLbl.text = model.post_title;
    [cell.contentImg setImageWithURL:[NSURL URLWithString:model.item_small_pic] placeholderImage:[UIImage imageNamed:@"loading_240x180"]];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 210.0;
}
#pragma mark - slideView
- (void)leftChoose {
    [self.viewDeckController toggleLeftViewAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [_request clearDelegatesAndCancel];
}

@end
