//
//  LeftViewController.m
//  QingDaoQuan
//
//  Created by apple on 14-3-22.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftViewCell.h"
#import "NewsViewController.h"
#import "WipeViewController.h"
#import "PrimeRateViewController.h"
#import "GameViewController.h"
#import "ShoppingViewController.h"
#import "BlowoutViewController.h"
#import "IIViewDeckController.h"
#import "BodyguardViewController.h"
#import "MapViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)initializeTableView {
    _dataArray = [[NSArray alloc] initWithObjects:@"left_news",@"left_ma",@"left_sale",@"left_game",@"left_shopping",@"left_baoliao",@"alert_un_collection", nil];
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height -= 20;
    frame.origin.y += 20;
    _tableView = [[UITableView alloc] initWithFrame:frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_tableView];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor blackColor];
    [self initializeTableView];
}

#pragma mark - tableViewDeletate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"LeftViewCell" owner:self options:0] lastObject];
        cell.backgroundColor = [UIColor blackColor];
    }
    if (indexPath.row != 0) {
        cell.leftLabel.hidden = YES;
    }
    if (indexPath.row<6) {
        cell.headImage.image = [UIImage imageNamed:[_dataArray objectAtIndex:indexPath.row]];
    }
    if (indexPath.row == 6) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 35, 35)];
        imageView.image = [UIImage imageNamed:[_dataArray objectAtIndex:indexPath.row]];
        [cell.headImage addSubview:imageView];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 80, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"掌上世园";
        label.textColor = [UIColor whiteColor];
        [cell.headImage addSubview:label];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.viewDeckController closeLeftViewAnimated:YES completion:^(IIViewDeckController *controller, BOOL success) {
            if (success) {
                NewsViewController *newVC= [[NewsViewController alloc] init];
                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:newVC];
                
                self.viewDeckController.centerController = nc;
                self.view.userInteractionEnabled = YES;
            }
        }];
    } else if (indexPath.row == 1) {
        [self.viewDeckController closeLeftViewAnimated:YES completion:^(IIViewDeckController *controller, BOOL success) {
            if (success) {
                WipeViewController *newVC= [[WipeViewController alloc] init];
                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:newVC];
                self.viewDeckController.centerController = nc;
                self.view.userInteractionEnabled = YES;
            }
        }];
    } else if (indexPath.row == 2) {
        [self.viewDeckController closeLeftViewAnimated:YES completion:^(IIViewDeckController *controller, BOOL success) {
            if (success) {
                PrimeRateViewController *newVC= [[PrimeRateViewController alloc] init];
                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:newVC];
                self.viewDeckController.centerController = nc;
                self.view.userInteractionEnabled = YES;
            }
        }];
    } else if (indexPath.row == 3) {
        [self.viewDeckController closeLeftViewAnimated:YES completion:^(IIViewDeckController *controller, BOOL success) {
            if (success) {
                GameViewController *newVC= [[GameViewController alloc] init];
                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:newVC];
                self.viewDeckController.centerController = nc;
                self.view.userInteractionEnabled = YES;
            }
        }];
    } else if (indexPath.row == 4) {
        [self.viewDeckController closeLeftViewAnimated:YES completion:^(IIViewDeckController *controller, BOOL success) {
            if (success) {
                ShoppingViewController *newVC= [[ShoppingViewController alloc] init];
                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:newVC];
                self.viewDeckController.centerController = nc;
                self.view.userInteractionEnabled = YES;
            }
        }];
    } else if (indexPath.row == 5) {
        [self.viewDeckController closeLeftViewAnimated:YES completion:^(IIViewDeckController *controller, BOOL success) {
            if (success) {
                BlowoutViewController *newVC= [[BlowoutViewController alloc] init];
                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:newVC];
                self.viewDeckController.centerController = nc;
                self.view.userInteractionEnabled = YES;
            }
        }];
    }
    else {
        [self.viewDeckController closeLeftViewAnimated:YES completion:^(IIViewDeckController *controller, BOOL success) {
            if (success) {
//                BodyguardViewController *bvc= [[BodyguardViewController alloc] init];
                MapViewController *bvc = [[MapViewController alloc] init];
                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:bvc];
                self.viewDeckController.centerController = nc;
                self.view.userInteractionEnabled = YES;
            }
        }];
        
    }
    
}

@end
