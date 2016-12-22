//
//  MessageController.m
//  SQLite3
//
//  Created by mac on 16/12/21.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "MessageController.h"
#import "SQManagerTool.h"
#import "PeopleModel.h"
@interface MessageController ()
{
    NSArray *resultArr;
}
@end

@implementation MessageController

static NSString * const CellReuseIdentifier1 = @"Cell1";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellReuseIdentifier1];
    
    [[SQManagerTool sharedInstance] selectMyTable:^(NSArray *result) {
        resultArr = result;
        [_tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return resultArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier1];
    
    PeopleModel *people = resultArr[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"姓名：%@   性别：%@   年龄：%@   ",people.name,people.sex,people.age];
    
    return cell;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
}
@end
