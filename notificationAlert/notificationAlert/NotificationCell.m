//
//  NotificationCell.m
//  notificationAlert
//
//  Created by careyang on 2018/6/11.
//  Copyright © 2018年 careyang. All rights reserved.
//

#import "NotificationCell.h"
#import "NotificationModel.h"

@implementation NotificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void) prepareForReuse
{
    [super prepareForReuse];
    self.titleLabel.text = nil;
    self.contentLabel.text = nil;
}

-(void) updateViewWithModel:(NotificationModel *) model
{
    if (model.messageTitle) {
        self.titleLabel.text = model.messageTitle;
    }

    if (model.messageContent) {
        self.contentLabel.text = model.messageContent;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
