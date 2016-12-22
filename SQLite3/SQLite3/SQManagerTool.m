//
//  SQManagerTool.m
//  SQLite3
//
//  Created by mac on 16/12/20.
//  Copyright © 2016年 zhang. All rights reserved.
//

#import "SQManagerTool.h"
#import "PeopleModel.h"
@implementation SQManagerTool


+(instancetype)sharedInstance
{
    static SQManagerTool *sharedManager;
    static dispatch_once_t onceManager;
    dispatch_once(&onceManager, ^{
        sharedManager = [[SQManagerTool alloc]init];
    });
    return sharedManager;
}


// 路径
-(NSString *)path{
    
//    NSArray *documentArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentPath = [documentArr firstObject];
//    // crylown.db 为数据库的名字
    NSString *path = [NSString stringWithFormat:@"/Users/mac/Desktop/ZWSqlite.db"];
    
    NSLog(@" path --------- %@",path);
    
    return path;
}

//创建数据库
-(void)creat
{
    [self open];
    char *error;
    NSString * sql = @"create table if not exists mySQLite(id integer primary key autoincrement,name char,sex char,age char)";
    const char * a =[sql  UTF8String];
    int tableResult = sqlite3_exec(database,a, NULL, NULL, &error);
    if (tableResult != SQLITE_OK) {
        NSLog(@"创建表失败:%s",error);
    }
    [self close];
}

// 打开/创建数据库
-(void)open
{
    int databaseResult = sqlite3_open([[self path] UTF8String], &database);
    if (databaseResult != SQLITE_OK) {
        NSLog(@"打开数据库失败,%d",databaseResult);
    }
}

-(void)close
{
    //  销毁stmt,回收资源
    sqlite3_finalize(stmt);
    //  关闭数据库
    sqlite3_close(database);
}

-(void)insertMyTableWithArr:(NSArray *)dataArr{
    //   添加
    //   sql语句格式: insert into 表名 (列名)values(值)
    [self open];
    
    [self traverseInsertData:dataArr];

    [self close];
}

-(void)traverseInsertData:(NSArray *)data
{
    if (data.count>0) {
        for (NSDictionary *dic in data) {
           
            const char *insertSQL = [[self insertSQL:dic] UTF8String];
            
            int insertResult = sqlite3_prepare_v2(database, insertSQL, -1, &stmt, nil);
            
            if (insertResult != SQLITE_OK) {
                NSLog(@"添加失败,%d",insertResult);
            }else{
                // 执行sql语句
                sqlite3_step(stmt);
            }
        }
    }
}

-(NSString *)insertSQL:(NSDictionary *)dic
{
    NSString *sql;
    NSString *name = [dic objectForKey:@"name"];
    NSString *sex  = [dic objectForKey:@"sex"];
    NSString *age  = [dic objectForKey:@"age"];
    
    sql = [NSString stringWithFormat:@"insert into mySQLite (name,sex,age)values('%@','%@','%@')",name,sex,age];
    return sql;
}

-(void)deleteDataWith:(NSString *)str
{
    //  删除
    //  sql语句格式: delete from 表名 where 列名 ＝ 参数     注：后面的 列名 ＝ 参数 用于判断删除哪条数据
    
    [self open];
    
    NSString *sql ;
//    指定删除
//    sql = [NSString stringWithFormat:@"delete from mySQLite where name = '%@'",str];

//    删除表中所有数据
    sql = @"delete from mySQLite";
    
    const char *deleteSQL = [sql UTF8String];
    
    int deleteResult = sqlite3_prepare_v2(database, deleteSQL, -1, &stmt, nil);
    
    if (deleteResult != SQLITE_OK) {
        
        NSLog(@"删除失败,%d",deleteResult);
    }
    else{
        sqlite3_step(stmt);
    }
    [self close];
}

//改
-(void)updateMydataWith:(NSString *)newName oldStr:(NSString *)oldName
{
    [self open];
    // sql语句格式: update 表名 set  列名 = 新参数 where 列名 ＝ 参数   注：前面的 列名 ＝ 新参数 是修改的值, 后面的 列名 ＝ 参数 用于判断删除哪条数据
    
    NSString *sql = [NSString stringWithFormat:@"update mySQLite set name = '%@' where name = '%@'",oldName,newName];

    const char *changeSQL = [sql UTF8String];
    
    int updateResult = sqlite3_prepare_v2(database, changeSQL, -1, &stmt, nil);
    
    if (updateResult != SQLITE_OK) {
        
        NSLog(@"修改失败,%d",updateResult);
    }
    else{
        sqlite3_step(stmt);
    }
    [self close];
}

//查
-(void)selectMyTable:(selectResult)results
{
    [self open];
    
    NSMutableArray *totlaArr = [NSMutableArray array];
    
    NSString *sql = @"select *from mySQLite ";
    const char *selectSQL = [sql UTF8String];

    int result = sqlite3_prepare_v2(database, selectSQL, -1, &stmt, nil);
    
    if (result != SQLITE_OK) {
        NSLog(@"查询失败,%d",result);
    }
    else{
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            // 查询的结果是所有数据,直到 sqlite3_step(stmt) != SQLITE_ROW,查询结束。
//            int idWord = sqlite3_column_int(stmt, 0);
            char *name = (char *)sqlite3_column_text(stmt, 1);
            char *sex = (char *)sqlite3_column_text(stmt, 2);
            char *age = (char *)sqlite3_column_text(stmt, 3);
            
            
            NSLog(@"数据查询结果 --- %s,%s，%s",name,sex,age);
            NSDictionary *dic = @{@"name":[NSString stringWithUTF8String:name],@"sex":[NSString stringWithUTF8String:sex],@"age":[NSString stringWithUTF8String:age]};
            
            PeopleModel *people = [[PeopleModel alloc]init];
           
            [people setValuesForKeysWithDictionary:dic];
          
            [totlaArr addObject:people];
            
        }
    }
    [self close];
    
    results(totlaArr);
    
}

@end
