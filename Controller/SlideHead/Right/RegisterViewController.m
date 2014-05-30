//
//  RegisterViewController.m
//  QingDaoQuan
//
//  Created by apple on 14-3-29.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
- (void)initializaTextField {
    self.userEmailTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 64+20, 240, 44)];
    self.userEmailTextField.placeholder = @"请输入邮箱";
    self.userEmailTextField.delegate = self;
    self.userEmailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userEmailTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.userEmailTextField];
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 84+44+20, 240, 44)];
    self.passwordTextField.placeholder = @"请输入密码";
    self.passwordTextField.delegate = self;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.passwordTextField];
    
    self.confirmTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 144+64, 240, 44)];
    self.confirmTextField.placeholder = @"请再次输入密码";
    self.confirmTextField.delegate = self;
    self.confirmTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.confirmTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.confirmTextField];
    
    self.nickNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 204+64, 240, 44)];
    self.nickNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.nickNameTextField.placeholder = @"请输入昵称";
    self.nickNameTextField.delegate = self;
    self.nickNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.nickNameTextField];
    
    UIButton *registerBut = [UIButton buttonWithType:UIButtonTypeSystem];
    registerBut.frame = CGRectMake(40, 268+64, 240, 44);
    [registerBut addTarget:self action:@selector(requestStart) forControlEvents:UIControlEventTouchUpInside];
    [registerBut setTitle:@"注册" forState:UIControlStateNormal];
    [self.view addSubview:registerBut];
}
#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor =[ UIColor whiteColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"main_top_noLine"] forBarMetrics:UIBarMetricsDefault];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 89, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"用户注册";
    label.font = [UIFont systemFontOfSize:22];
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
    [self initializeBarButton];
    [self initializaTextField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyBoardWillShow:(NSNotification *)noti {
    if ([self.nickNameTextField isFirstResponder]) {
        CGSize size = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2f];
        CGRect frame = self.view.frame;
        frame.origin.y -= size.height;
        self.view.frame = frame;
        [UIView commitAnimations];
    }
    
}
- (void)keyBoardWillHide:(NSNotification *)noti {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2f];
    self.view.frame = CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height);
    [UIView commitAnimations];
}
- (void)leftChoose {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - requestStart
- (void)requestStart {
    if (![self isValidateEmail:self.userEmailTextField.text]) {
        UIAlertView *alertView = [[UIAlertView alloc ] initWithTitle:@"错误" message:@"邮箱错误" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    if (self.userEmailTextField.text.length<1 || self.passwordTextField.text.length<1 || self.confirmTextField.text.length<1 || self.nickNameTextField.text.length<1) {
        UIAlertView *alertView = [[UIAlertView alloc ] initWithTitle:@"错误" message:@"信息错误" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    if (![self.passwordTextField.text isEqualToString:self.confirmTextField.text]) {
        UIAlertView *alertView = [[UIAlertView alloc ] initWithTitle:@"错误" message:@"俩次输入密码不一致" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    self.request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://zsqd.qdqss.cn/new/login.ashx"]];
    [self.request setPostValue:self.userEmailTextField.text forKey:@"user_email"];
    [self.request setPostValue:@"register" forKey:@"action"];
    [self.request setPostValue:@"" forKey:@"user_login"];
    [self.request setPostValue:self.passwordTextField.text forKey:@"user_pass"];
    [self.request setPostValue:self.nickNameTextField.text forKey:@"nickname"];
    self.request.delegate = self;
    [self.request startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request {
    if ([[[NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil] objectForKey:@"data"] boolValue]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"注册失败" delegate:nil cancelButtonTitle:@"返回" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"%@",request.responseString);
}

-(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}
#pragma mark - textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.userEmailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.confirmTextField resignFirstResponder];
    [self.nickNameTextField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.userEmailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.confirmTextField resignFirstResponder];
    [self.nickNameTextField resignFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.request cancel];
}

@end
