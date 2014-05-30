//
//  RightViewController.m
//  QingDaoQuan
//
//  Created by apple on 14-3-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "RightViewController.h"
#import "IIViewDeckController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loginClick {
    UITapGestureRecognizer *loginTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginAction)];
    [self.accountLable addGestureRecognizer:loginTap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginAction)];
    [self.userImg addGestureRecognizer:tap2];
}
- (void)loginAction {
    [self.viewDeckController closeRightViewBouncing:^(IIViewDeckController *controller) {
        LoginViewController *lvc = [[LoginViewController alloc] init];
        //        apiVC.title = @"左侧边栏子视图";
        lvc.delegate = self;
        UINavigationController *navApiVC = [[UINavigationController alloc] initWithRootViewController:lvc];
//        navApiVC.delegate = self;
        self.viewDeckController.centerController = navApiVC;
        self.view.userInteractionEnabled = YES;
    }];
}
#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self loginClick];
}

- (void)sendMessage:(NSString *)str integer:(NSNumber *)integer {
    self.accountLable.text = str;
    self.integerLabel.text = [NSString stringWithFormat:@"积分:%@",integer];
    [self.viewDeckController toggleRightViewAnimated:YES];
}

- (IBAction)weatherClick:(id)sender {
    [self.viewDeckController closeRightViewBouncing:^(IIViewDeckController *controller) {
        LoginViewController *lvc = [[LoginViewController alloc] init];
//        apiVC.title = @"左侧边栏子视图";
        UINavigationController *navApiVC = [[UINavigationController alloc] initWithRootViewController:lvc];
        self.viewDeckController.centerController = navApiVC;
        self.view.userInteractionEnabled = YES;
    }];
}
@end
