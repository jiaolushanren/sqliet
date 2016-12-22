//
//  MessageController.h
//  SQLite3
//
//  Created by mac on 16/12/21.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageController : UIViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
