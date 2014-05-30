//
//  RegisterViewController.h
//  QingDaoQuan
//
//  Created by apple on 14-3-29.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"

@interface RegisterViewController : UIViewController <UITextFieldDelegate,ASIHTTPRequestDelegate>

@property (nonatomic,retain) UITextField *userEmailTextField;
@property (nonatomic,retain) UITextField *passwordTextField;
@property (nonatomic,retain) UITextField *confirmTextField;
@property (nonatomic,retain) UITextField *nickNameTextField;
@property (nonatomic,retain) ASIFormDataRequest *request;

@end
