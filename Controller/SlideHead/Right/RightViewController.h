//
//  RightViewController.h
//  QingDaoQuan
//
//  Created by apple on 14-3-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface RightViewController : UIViewController <LoginViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *accountLable;
@property (weak, nonatomic) IBOutlet UILabel *integerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
- (IBAction)weatherClick:(id)sender;

@end
