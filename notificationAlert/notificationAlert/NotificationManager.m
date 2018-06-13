//
//  NotificationManager.m
//  notificationAlert
//
//  Created by careyang on 2018/6/11.
//  Copyright © 2018年 careyang. All rights reserved.
//

#import "NotificationManager.h"
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>
#import "NotificationModel.h"
#import <CoreLocation/CoreLocation.h>
@interface NotificationManager()<UNUserNotificationCenterDelegate>

@end

@implementation NotificationManager
#pragma mark 请求推送权限
+(void) requestNotificationAuth
{
    if (@available(iOS 10, *)) {
        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        //请求权限
        [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {

        }];
    }
    else if (@available(iOS 8 , *)) {
        UIUserNotificationSettings * setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}
#pragma mark 创建只有文字形式的推送
+(void) createNotification_onlyText
{
    //设置推送内容
    UNMutableNotificationContent * content = [[UNMutableNotificationContent alloc] init];
    content.title = @"推送的标题";
    content.body = @"推送的内容";
    content.subtitle = @"推送的子标题";
    content.badge = [NSNumber numberWithInteger:0];// 红标
    content.sound = [UNNotificationSound defaultSound];
    //[UNNotificationSound soundNamed:@""]; 自定义推送声音

    UNTextInputNotificationAction *action1 = [UNTextInputNotificationAction actionWithIdentifier:@"replyAction" title:@"文字回复" options:UNNotificationActionOptionNone];
    UNNotificationAction *action2 = [UNNotificationAction actionWithIdentifier:@"enterAction" title:@"进入应用" options:UNNotificationActionOptionForeground];

    UNNotificationAction *action3 = [UNNotificationAction actionWithIdentifier:@"cancelAction" title:@"取消" options:UNNotificationActionOptionDestructive];

    UNNotificationCategory *categroy = [UNNotificationCategory categoryWithIdentifier:@"CategroyAction" actions:@[action1,action2,action3] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];

    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObject:categroy]];
//    [[UNUserNotificationCenter currentNotificationCenter] setDelegate:self];
    content.categoryIdentifier = @"CategroyAction";

    //设置推送的触发机制
    UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];

    //日历形式，
//    NSDateComponents * dateComp = [[NSDateComponents alloc] init];
//    dateComp.weekday = 2;//周一,默认第一天是周日
//    dateComp.month = 12;//月份，您可以在这里设置具体的时分秒
//    dateComp.hour = 10;//小时
//    dateComp.minute = 14;//分钟
//    UNCalendarNotificationTrigger * calendarTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComp repeats:YES];

    //地理位置推送.没实际应用过
//    CLLocationCoordinate2D  location ;
//    location.latitude = 123;
//    location.longitude = 111;
//
//    CLCircularRegion * region = [[CLCircularRegion alloc] initWithCenter:location radius:100.0 identifier:@"regionid"];
//
//    UNLocationNotificationTrigger * locationTrigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:YES];

    NSString * identifier = @"notification_onlytextid";
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {

    }];
}

+(void)createNotification_textAndImage
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"推送标题";
    content.subtitle = @"推送子标题";
    content.body = @"推送的内容~";
    content.badge = @0;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"rank2" ofType:@"png"];
    NSError *error = nil;
    /*
     UNNotificationAttachment是指可以包含音频，图像或视频内容。使用本地通知时，可以在通知创建时，将附件加入即可。对于远程通知，则必须实现使用UNNotificationServiceExtension类通知服务扩展。
     */
    UNNotificationAttachment *img_attachment = [UNNotificationAttachment attachmentWithIdentifier:@"att1" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    if (error) {
        NSLog(@"%@", error);
    }

    content.attachments = @[img_attachment];//默认只显示第一个

    content.launchImageName = @"launch2";
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;

    //如果 requestIdentifer 相同的话，会直接顶替原来的，在通知栏只显示最新的推送
    UNTimeIntervalNotificationTrigger *time_trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
    NSString *requestIdentifer = @"notification_textAndImage";
    content.categoryIdentifier = @"textAndImage";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:time_trigger];

    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

+(void) createNotification_video
{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"推送标题";
    content.subtitle = @"推送子标题";
    content.body = @"推送的内容~";
    content.badge = @0;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"combine" ofType:@"mp4"];
    NSError *error = nil;
    /*
     UNNotificationAttachment是指可以包含音频，图像或视频内容。使用本地通知时，可以在通知创建时，将附件加入即可。对于远程通知，则必须实现使用UNNotificationServiceExtension类通知服务扩展。
     */
    UNNotificationAttachment *img_attachment = [UNNotificationAttachment attachmentWithIdentifier:@"att2" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    if (error) {
        NSLog(@"%@", error);
    }

    content.attachments = @[img_attachment];//默认只显示第一个

//    content.launchImageName = @"launch2";
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;

    //如果 requestIdentifer 相同的话，会直接顶替原来的，在通知栏只显示最新的推送
    UNTimeIntervalNotificationTrigger *time_trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];
    NSString *requestIdentifer = @"notification_textAndVideo";
    content.categoryIdentifier = @"video";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifer content:content trigger:time_trigger];

    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

-(void) userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    NSString * categoryid = response.notification.request.content.categoryIdentifier;
    NSLog(@"收到通知：%@",response.notification.request.content);
    //识别同类类型id
    if ([categoryid isEqualToString:@"CategroyAction"])
    {
        //识别通知操作动作的id
        if ([response.actionIdentifier isEqualToString:@"replyAction"])
        {
            UNTextInputNotificationResponse * textResponse = (UNTextInputNotificationResponse *) response;
            NSString * text = textResponse.userText;
            //此为输入的内容
        }
    }
    completionHandler();
}
//只有当前处于前台才会走，加上返回方法，使在前台显示信息
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{

    NSLog(@"执行willPresentNotificaiton");
    completionHandler(UNNotificationPresentationOptionBadge|
                      UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionAlert);
}
#pragma mark project 中根据model 创建notification
+(BOOL) createANotificationWithMode:(NotificationModel *) model
{
    BOOL isSuccess = NO;

    if (@available(iOS 10 , *))
    {
        //设置推送内容
        UNMutableNotificationContent * content = [[UNMutableNotificationContent alloc] init];
        content.title = model.messageTitle;
        content.body = model.messageContent;
//        content.subtitle = @"";//子标题，ios10 之下没有这个值
        content.badge = [NSNumber numberWithInteger:0];
        content.sound = [UNNotificationSound defaultSound];
        //[UNNotificationSound soundNamed:@""]; 自定义推送声音
        //设置推送的触发机制
        UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10 repeats:NO];

        NSString * identifier = [NSString stringWithFormat:@"%f",[model.createDate timeIntervalSince1970] * 1000];
        UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {

                                 }];
    }
    else
    {
        // ios10一下用UILocal
        UILocalNotification * notification = [[UILocalNotification alloc] init];
        notification.alertTitle = model.messageTitle;
        notification.alertBody = model.messageContent;
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];//10s 后
        notification.soundName = UILocalNotificationDefaultSoundName;
//        [[UIApplication sharedApplication] presentLocalNotificationNow:notification]; 立即触发
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];//到设定时间触发
    }

    return isSuccess;
}


+(BOOL) deleteANotificationWithTime:(NSTimeInterval) createTime
{
    BOOL isSuccess = NO;
    NSString * ident = [NSString stringWithFormat:@"%f",createTime];

    [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {

        for (NSInteger i = 0 ; i < requests.count; i++)
        {
            UNNotificationRequest * req = requests[i];
            if ([req.identifier isEqualToString:ident]) {
                [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[ident]];
                break;
            }
        }

    }];

    return isSuccess;
}

#pragma mark 没权限的弹窗
+(void) showGoSettingAlert
{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"您还没有允许推送权限" message:@"去设置一下吧" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];
    UIAlertAction * setAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }];

    [alert addAction:cancelAction];
    [alert addAction:setAction];
    UIWindow * window =[[UIApplication sharedApplication].delegate window];
    UIViewController * vc = window.rootViewController;
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
