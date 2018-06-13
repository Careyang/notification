//
//  NotificationModel.h
//  notificationAlert
//
//  Created by careyang on 2018/6/11.
//  Copyright © 2018年 careyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationModel : NSObject<NSCoding>

@property (nonatomic , strong) NSString * messageTitle;

@property (nonatomic , strong) NSString * messageContent;

//@property (nonatomic , strong) NSString * messageIcon;

@property (nonatomic , strong) NSDate * remindDate;

@property (nonatomic , strong) NSDate * createDate;

@end
