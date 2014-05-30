//
//  UserModel.m
//  QingDaoQuan
//
//  Created by apple on 14-4-1.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (UserModel *)sharedUser {
    static UserModel *model = nil;
    if (model == nil) {
        model = [[UserModel alloc] init];
    }
    return model;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
