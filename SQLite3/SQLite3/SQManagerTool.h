//
//  SQManagerTool.h
//  SQLite3
//
//  Created by mac on 16/12/20.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

typedef void(^selectResult)(NSArray *result);

//typedef enum{
//    insert = 0, //增
//    
//    deletes, //删
//    
//    update, //改
//    
//    selects //查
//}SQType;

@interface SQManagerTool : NSObject

{
    sqlite3 *database;
    sqlite3_stmt *stmt;
}


/**
 创建单例对象

 */
+(instancetype)sharedInstance;

//创建数据库
-(void)creat;


//增
-(void)insertMyTableWithArr:(NSArray *)dataArr;

//删
-(void)deleteDataWith:(NSString *)str;

//改
-(void)updateMydataWith:(NSString *)newName oldStr:(NSString *)oldName;

//查
-(void)selectMyTable:(selectResult)results;


@end
