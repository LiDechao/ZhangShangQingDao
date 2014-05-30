//
//  BaseLocalViewCell.h
//  QingDaoQuan
//
//  Created by apple on 14-3-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsContent;
@property (weak, nonatomic) IBOutlet UILabel *newsLive;

@end
