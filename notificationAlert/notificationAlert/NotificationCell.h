//
//  NotificationCell.h
//  notificationAlert
//
//  Created by careyang on 2018/6/11.
//  Copyright © 2018年 careyang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NotificationModel;
@interface NotificationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
-(void) updateViewWithModel:(NotificationModel *) model;
@end
