//
//  ViewController.m
//  SQLite3
//
//  Created by mac on 16/12/20.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "ViewController.h"
#import "SQManagerTool.h"
#import "MessageController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[SQManagerTool sharedInstance] creat];

}



- (IBAction)insertMessageForSqlite:(id)sender {
    
    if (_nameTF.text.length==0||_sexTF.text.length==0||_ageTF.text.length==0) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提 示" message:@"请把信息填写完整" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
        
        
        return;
    }
    
    NSDictionary *dic = @{@"name":_nameTF.text,@"sex":_sexTF.text,@"age":_ageTF.text};
    
    [[SQManagerTool new] insertMyTableWithArr:@[dic]];
}

- (IBAction)presentWithMessageVC:(id)sender {
    
    [self presentViewController:[MessageController new] animated:YES completion:^{
        
    }];
    
}
@end
