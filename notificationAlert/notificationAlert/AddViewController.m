//
//  AddViewController.m
//  notificationAlert
//
//  Created by careyang on 2018/6/11.
//  Copyright © 2018年 careyang. All rights reserved.
//

#import "AddViewController.h"
#import "NotificationModel.h"
#import "NotificationManager.h"
@interface AddViewController ()
@property (nonatomic , strong) NotificationModel * model;
@property (weak, nonatomic) IBOutlet UITextField *titleTextF;
@property (weak, nonatomic) IBOutlet UITextField *contentTextF;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (IBAction)confirmBtnClick:(UIButton *)sender
{
    self.model = [NotificationModel new];
    self.model.messageTitle = @"测试标题";
    self.model.messageContent = @"测试内容";
    self.model.remindDate = [NSDate dateWithTimeIntervalSinceNow:100];
    self.model.createDate = [NSDate date];

    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString * filePath = [path stringByAppendingPathComponent:@"list.plist"];

    NSLog(@"==%@",filePath);

    NSMutableArray * array = [NSMutableArray arrayWithContentsOfFile:filePath];

    if (array == nil || array.count < 1) {
        array = [NSMutableArray array];
    }

    [array insertObject:self.model atIndex:0];

    BOOL isSuccess = [NSKeyedArchiver archiveRootObject:array toFile:filePath];

    [NotificationManager createANotificationWithMode:self.model];

    if (isSuccess) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
