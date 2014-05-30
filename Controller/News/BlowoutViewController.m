//
//  BlowoutViewController.m
//  QingDaoQuan
//
//  Created by apple on 14-3-26.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "BlowoutViewController.h"
#import "IIViewDeckController.h"

@interface BlowoutViewController ()

@end

@implementation BlowoutViewController {
    UIView *_bagView;
    UITextField *_nameTextField;
    UITextField *_contentTextField;
    UITextView *_describeTextView;
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 89, 22)];
    label.text = @"爆料";
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:22];
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label;
    
    [self initializeBarButton];
    [self initializaTextField];
}
- (void)initializaTextField {
    _bagView = [[UIView alloc] initWithFrame:CGRectMake(20, 20+44+20, 280, 40+40+160)];
    _bagView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"baoliao_Bg"]];
    [self.view addSubview:_bagView];
    
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 270, 40)];
    _nameTextField.borderStyle = UITextBorderStyleNone;
    _nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameTextField.placeholder = @"姓名:";
    _nameTextField.delegate = self;
    UIView *leftNameView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    leftNameView.backgroundColor = [UIColor clearColor];
    _nameTextField.leftView = leftNameView;
    _nameTextField.leftViewMode = UITextFieldViewModeAlways;
    [_bagView addSubview:_nameTextField];
    
    _contentTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 40, 270, 40)];
    _contentTextField.delegate = self;
    _contentTextField.borderStyle = UITextBorderStyleNone;
    _contentTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _contentTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _contentTextField.placeholder = @"联系方式:";
    UIView *leftContView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 40)];
    leftContView.backgroundColor = [UIColor clearColor];
    _contentTextField.leftView = leftContView;
    _contentTextField.leftViewMode = UITextFieldViewModeAlways;
    [_bagView addSubview:_contentTextField];
    
    _describeTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 80, 270, 160)];
    _describeTextView.clearsContextBeforeDrawing = YES;
    _describeTextView.backgroundColor = [UIColor clearColor];
    _describeTextView.returnKeyType = UIReturnKeyDefault;
    _describeTextView.scrollEnabled = YES;
    _describeTextView.delegate = self;
    _describeTextView.text = @"描述:";
    [_bagView addSubview:_describeTextView];
    
    UIButton *addImgBut = [UIButton buttonWithType:UIButtonTypeSystem];
    [addImgBut setTitle:@"添加照片" forState:UIControlStateNormal];
    addImgBut.titleLabel.textColor = [UIColor blackColor];
    [addImgBut setBackgroundImage:[UIImage imageNamed:@"txt_background_day"] forState:UIControlStateNormal];
    addImgBut.frame = CGRectMake(20, 20+44+20+80+160+10, 130, 40);
    [self.view addSubview:addImgBut];
    
    UIButton *submitBut = [UIButton buttonWithType:UIButtonTypeSystem];
    submitBut.frame = CGRectMake(130+20+20, 20+44+20+80+160+10, 130, 40);
    [submitBut setBackgroundImage:[UIImage imageNamed:@"baoliao_submit"] forState:UIControlStateNormal];
    [self.view addSubview:submitBut];
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
#pragma mark - slideView

- (void)leftChoose {
    [self.viewDeckController toggleLeftViewAnimated:YES];
}
#pragma mark - textView delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [_describeTextView resignFirstResponder];
        [_nameTextField resignFirstResponder];
        [_contentTextField resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (textView.text.length == 3) {
        _describeTextView.text = @"";
        _describeTextView.textColor = [UIColor blackColor];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        _describeTextView.text = @"描述:";
    }
}
#pragma mark - textField
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    if ([string isEqualToString:@"\n"]) {
//        [_describeTextView resignFirstResponder];
//        [_nameTextField resignFirstResponder];
//        [_contentTextField resignFirstResponder];
//        return NO;
//    }
//    return YES;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_nameTextField resignFirstResponder];
    [_contentTextField resignFirstResponder];
    [_describeTextView resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_nameTextField resignFirstResponder];
    [_contentTextField resignFirstResponder];
    [_describeTextView resignFirstResponder];
}

@end
