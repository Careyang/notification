//
//  NotificationManager.h
//  notificationAlert
//
//  Created by careyang on 2018/6/11.
//  Copyright © 2018年 careyang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NotificationModel;

@interface NotificationManager : NSObject

+(void) requestNotificationAuth;

#pragma mark 范例

+(void) createNotification_onlyText;

+(void)createNotification_textAndImage;

+(void) createNotification_video;

#pragma mark project
+(void) showGoSettingAlert;

+(BOOL) createANotificationWithMode:(NotificationModel *) model;

+(BOOL) deleteANotificationWithTime:(NSTimeInterval) createTime;


@end
