//
//  UserModel.h
//  QingDaoQuan
//
//  Created by apple on 14-4-1.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,copy) NSString *user_login;
@property (nonatomic,copy) NSString *display_name;
@property (nonatomic,copy) NSString *user_head;
@property (nonatomic,copy) NSString *user_email;
@property (nonatomic,retain) NSNumber *user_jf;

@property (nonatomic,assign) BOOL isOn;

+ (UserModel *)sharedUser;

@end
