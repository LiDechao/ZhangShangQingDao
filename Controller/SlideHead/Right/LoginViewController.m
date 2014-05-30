//
//  LoginViewController.m
//  QingDaoQuan
//
//  Created by apple on 14-3-28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "IIViewDeckController.h"
#import "NewsViewController.h"
#import "RegisterViewController.h"
#import "UserModel.h"

@interface LoginViewController ()

@end

@implementation LoginViewController {
    UITextField *_nameTextField;
    UITextField *_passwordTextField;
    ASIFormDataRequest *_request;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"main_top_noLine"] forBarMetrics:UIBarMetricsDefault];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 89, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"用户登陆";
    label.font = [UIFont systemFontOfSize:22];
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
    self.nickName = [[NSString alloc] init];
    [self initializeBarButton];
    [self createTextField];
    [self createButton];
}
#pragma mark - initializeBarButton
- (void)initializeBarButton {
    //leftButton
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(-2, 9, 18, 20)];
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"<";
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont boldSystemFontOfSize:28];
    [leftView addSubview:label1];
    leftView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftChoose)];
    [leftView addGestureRecognizer:tap];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)leftChoose {
//    [self.navigationController popViewControllerAnimated:YES];
    [self.viewDeckController closeRightViewAnimated:YES duration:1.0 completion:^(IIViewDeckController *controller,BOOL success){
        if (success) {
            NewsViewController *newsView = [[NewsViewController alloc] init];
            UINavigationController *newsNav = [[UINavigationController alloc] initWithRootViewController:newsView];
            self.viewDeckController.centerController = newsNav;
            self.view.userInteractionEnabled = YES;
        }
    }];
}
- (void)createTextField {
    _nameTextField = [[UITextField alloc ] initWithFrame:CGRectMake(60, 20+44+20, 200, 40)];
    _nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    _nameTextField.placeholder = @"账号";
    _nameTextField.delegate = self;
    _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_nameTextField];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 20+44+20+40+20, 200, 40)];
    _passwordTextField.placeholder = @"密码";
    _passwordTextField.delegate = self;
    _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_passwordTextField];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_nameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}
#pragma mark - createButton
- (void)createButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(60, 200, 200, 40);
    button.layer.cornerRadius = 10;
    button.backgroundColor = [UIColor blueColor];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.font = [ UIFont boldSystemFontOfSize:23];
    [button setTitle:@"登陆" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *registerBut = [UIButton buttonWithType:UIButtonTypeSystem];
    registerBut.frame = CGRectMake(60, 260, 200, 40);
    registerBut.layer.cornerRadius = 10;
    registerBut.titleLabel.textColor = [UIColor whiteColor];
    registerBut.titleLabel.font = [ UIFont boldSystemFontOfSize:23];
    registerBut.backgroundColor = [UIColor blueColor];
    [registerBut setTitle:@"注册" forState:UIControlStateNormal];
    [registerBut addTarget:self action:@selector(registerButClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBut];
}
- (void)registerButClick {
    RegisterViewController *rvc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:rvc animated:YES];
}
- (void)buttonClick {
    _request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://zsqd.qdqss.cn/new/login.ashx"]];
    _request.delegate = self;
    [_request setPostValue:_nameTextField.text forKey:@"user_email"];
    [_request setPostValue:_passwordTextField.text forKey:@"user_pass"];
    [_request setPostValue:@"login" forKey:@"action"];
    [_request startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request {
    if ([[[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"error"] boolValue]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:@"用户名或密码错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *dataStr = [[[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"data"] objectForKey:@"display_name"];
    self.nickName = dataStr;
    self.user_jf =[[[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"data"] objectForKey:@"user_jf"];
    
    [[UserModel sharedUser] setValuesForKeysWithDictionary:[[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"data"]];
    UIAlertView *alertName = [[UIAlertView alloc] initWithTitle:@"欢迎你" message:dataStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"返回", nil];
    alertName.delegate = self;
    [alertName show];
}
- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"login...fail");
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self.viewDeckController closeRightViewAnimated:YES completion:^(IIViewDeckController *controller, BOOL success) {
            if (success) {
                NewsViewController *newVC= [[NewsViewController alloc] init];
                UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:newVC];
                self.viewDeckController.centerController = nc;
                self.view.userInteractionEnabled = YES;
                [self.delegate sendMessage:self.nickName integer:self.user_jf];
                [_nameTextField resignFirstResponder];
                [_passwordTextField resignFirstResponder];
            }
        }];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_nameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    return YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [_request clearDelegatesAndCancel];
}

@end
