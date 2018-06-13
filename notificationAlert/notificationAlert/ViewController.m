//
//  ViewController.m
//  notificationAlert
//
//  Created by careyang on 2018/6/11.
//  Copyright © 2018年 careyang. All rights reserved.
//

#import "ViewController.h"
#import "AddViewController.h"
#import "NotificationCell.h"
#import "NotificationManager.h"
#import "ExamplesViewController.h"

@interface ViewController ()<UITableViewDelegate , UITableViewDataSource>
@property (nonatomic , strong) NSMutableArray * notificationList;
@property (nonatomic , strong) UITableView * tableview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadLocalList];
}
- (IBAction)itemAddClick:(UIBarButtonItem *)sender
{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

    AddViewController * vc = [sb instantiateViewControllerWithIdentifier:@"AddViewController"];

    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)scanTestClick:(UIBarButtonItem *)sender
{

    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

    ExamplesViewController * vc = [sb instantiateViewControllerWithIdentifier:@"ExamplesViewController"];

    [self.navigationController pushViewController:vc animated:YES];
}
-(void) loadLocalList
{
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString * filePath = [path stringByAppendingPathComponent:@"list.plist"];

    NSMutableArray * arr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];

    self.notificationList = [NSMutableArray arrayWithArray:arr];

    [self.tableview reloadData];

}

#pragma mark 列表代理方法
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notificationList.count;
}

-(UITableViewCell * ) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotificationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NotificationCell" owner:nil options:nil] firstObject];
    }
    NotificationModel  * model = self.notificationList[indexPath.row];
    [cell updateViewWithModel:model];
    return cell;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.0f;
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [NotificationManager createNotification_textAndImage];
}
-(NSString *) tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.notificationList removeObjectAtIndex:indexPath.row];
        NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString * filePath = [path stringByAppendingPathComponent:@"list.plist"];

        [NSKeyedArchiver archiveRootObject:self.notificationList toFile:filePath];

        [self loadLocalList];
    }
}
-(UITableView *) tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.showsHorizontalScrollIndicator = NO;
        _tableview.tableFooterView = [UIView new];
        [self.view addSubview:_tableview];
    }
    return _tableview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
