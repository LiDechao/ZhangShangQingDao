//
//  LoginViewController.h
//  QingDaoQuan
//
//  Created by apple on 14-3-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"

@protocol LoginViewControllerDelegate <NSObject>

-(void) sendMessage:(NSString *)str integer:(NSNumber *)integer;

@end

@interface LoginViewController : UIViewController <ASIHTTPRequestDelegate,UITextFieldDelegate,UIAlertViewDelegate>

@property (nonatomic,assign) id<LoginViewControllerDelegate>delegate;
@property (nonatomic,retain) NSString *nickName;
@property (nonatomic,retain) NSNumber *user_jf;

@end
