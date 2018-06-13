//
//  ExamplesViewController.m
//  notificationAlert
//
//  Created by careyang on 2018/6/12.
//  Copyright © 2018年 careyang. All rights reserved.
//

#import "ExamplesViewController.h"
#import "NotificationManager.h"

@interface ExamplesViewController ()

@end

@implementation ExamplesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)createNotification_onlyText:(id)sender
{
    [NotificationManager createNotification_onlyText];
}
- (IBAction)createNotification_textAndImage:(UIButton *)sender
{
    [NotificationManager createNotification_textAndImage];
}
- (IBAction)createNotification_video:(UIButton *)sender
{
    [NotificationManager createNotification_video];
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
