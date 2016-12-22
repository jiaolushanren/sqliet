//
//  ViewController.h
//  SQLite3
//
//  Created by mac on 16/12/20.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *sexTF;

@property (weak, nonatomic) IBOutlet UITextField *ageTF;

- (IBAction)insertMessageForSqlite:(id)sender;
- (IBAction)presentWithMessageVC:(id)sender;

@end

