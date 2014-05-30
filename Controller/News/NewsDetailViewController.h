//
//  NewsDetailViewController.h
//  QingDaoQuan
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailViewController : UIViewController <UIWebViewDelegate,UITextFieldDelegate,UIWebViewDelegate> {
    UIView *_conView;
    UITextField *_textField;
    UIView *_writeView;
    UITextField *_writeTextField;
}

@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic,copy) NSString *requestURLStr;

@end
