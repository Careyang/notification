//
//  NotificationModel.m
//  notificationAlert
//
//  Created by careyang on 2018/6/11.
//  Copyright © 2018年 careyang. All rights reserved.
//

#import "NotificationModel.h"

@implementation NotificationModel

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    [aCoder encodeObject:self.messageTitle forKey:@"messageTitle"];
    [aCoder encodeObject:self.messageContent forKey:@"messageContent"];
//    [aCoder encodeObject:self.messageIcon forKey:@"messageIcon"];
    [aCoder encodeObject:self.remindDate forKey:@"remindDate"];
    [aCoder encodeObject:self.createDate forKey:@"createDate"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.messageTitle = [aDecoder decodeObjectForKey:@"messageTitle"];
//        self.messageIcon = [aDecoder decodeObjectForKey:@"messageIcon"];
        self.messageContent = [aDecoder decodeObjectForKey:@"messageContent"];
        self.remindDate = [aDecoder decodeObjectForKey:@"remindDate"];
        self.createDate = [aDecoder decodeObjectForKey:@"createDate"];
    }
    return self;
}
@end
