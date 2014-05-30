//
//  BaseLocalViewCell.m
//  QingDaoQuan
//
//  Created by apple on 14-3-24.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LocalViewCell.h"

@implementation LocalViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
