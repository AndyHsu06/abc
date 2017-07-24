//
//  sqlite.m
//  swift_call_c
//
//  Created by john2 on 2017/6/20.
//  Copyright © 2017年 haha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <sqlite3.h>



NSArray* get_numbers_from_db(NSString* column){
    
    NSMutableArray* data = [[NSMutableArray alloc]init];
    
    sqlite3* connect;
    //NSString* data_path_oc = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"sqlite"];
    NSString* temp = NSHomeDirectory();
    NSString* data_path_oc = [NSString stringWithFormat:@"%@%@",temp,@"/Documents/data.sqlite" ];

    
    char* data_path_c = (char*)[data_path_oc UTF8String];
    
    printf("BUNDLE------->%s", data_path_c);
    
    int result = sqlite3_open(data_path_c, &connect);
    if(result ==SQLITE_OK){
        char* sql = "SELECT %s FROM students;" ;
        char* sql_ok = malloc(100);
        memset(sql_ok, 0, 100);
        sprintf(sql_ok, sql, [column UTF8String]);
        sqlite3_stmt* command;
        result = sqlite3_prepare(
                                 connect,
                                 sql_ok,
                                 -1,
                                 &command,
                                 NULL
                                 );
        if(result ==SQLITE_OK){
            //sqlite3_bind_text(command, 1, (char*)[column UTF8String], -1, NULL);
            while(sqlite3_step(command)==SQLITE_ROW){
                
                int number = sqlite3_column_int(command, 0);
                NSNumber* nn = [NSNumber numberWithInt:number];
                [data addObject:nn];
                
            }
        
            sqlite3_finalize(command);
            
            
        }else{
            printf("建立命令物件失敗！！");
        }
        
    }else{
        //////連線失敗！！do something you want
        printf("連線失敗！！");
    }
    
    
    
    sqlite3_close(connect);

 

    return data;
}





NSArray* get_strings_from_db(NSString* column){
    
    NSMutableArray* data = [[NSMutableArray alloc]init];
    
    sqlite3* connect;
    //NSString* data_path_oc = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"sqlite"];
    NSString* temp = NSHomeDirectory();
    NSString* data_path_oc = [NSString stringWithFormat:@"%@%@",temp,@"/Documents/data.sqlite" ];

    char* data_path_c = (char*)[data_path_oc UTF8String];
    int result = sqlite3_open(data_path_c, &connect);
    if(result ==SQLITE_OK){
        char* sql = "SELECT %s FROM students;" ;
        char* sql_ok = malloc(100);
        memset(sql_ok, 0, 100);
        sprintf(sql_ok, sql, [column UTF8String]);
        sqlite3_stmt* command;
        result = sqlite3_prepare(
                                 connect,
                                 sql_ok,
                                 -1,
                                 &command,
                                 NULL
                                 );
        if(result ==SQLITE_OK){
            //sqlite3_bind_text(command, 1, (char*)[column UTF8String], -1, NULL);
            while(sqlite3_step(command)==SQLITE_ROW){
                
                char* name = (char*)sqlite3_column_text(command, 0);
                NSString* nn = [NSString stringWithUTF8String:name];
                [data addObject:nn];
                
            }
            
            sqlite3_finalize(command);
            
            
        }else{
            printf("建立命令物件失敗！！");
        }
        
    }else{
        //////連線失敗！！do something you want
        printf("連線失敗！！");
    }
    
    
    
    sqlite3_close(connect);
    
    
    
    
    
    return data;
}


NSArray* get_pictures_from_db(NSString* column){
    
    NSMutableArray* data = [[NSMutableArray alloc]init];
    
    sqlite3* connect;
    //NSString* data_path_oc = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"sqlite"];
    NSString* temp = NSHomeDirectory();
    NSString* data_path_oc = [NSString stringWithFormat:@"%@%@",temp,@"/Documents/data.sqlite" ];

    char* data_path_c = (char*)[data_path_oc UTF8String];
    int result = sqlite3_open(data_path_c, &connect);
    if(result ==SQLITE_OK){
        char* sql = "SELECT %s FROM students;" ;
        char* sql_ok = malloc(100);
        memset(sql_ok, 0, 100);
        sprintf(sql_ok, sql, [column UTF8String]);
        sqlite3_stmt* command;
        result = sqlite3_prepare(
                                 connect,
                                 sql_ok,
                                 -1,
                                 &command,
                                 NULL
                                 );
        if(result ==SQLITE_OK){
            //sqlite3_bind_text(command, 1, (char*)[column UTF8String], -1, NULL);
            while(sqlite3_step(command)==SQLITE_ROW){
                void* blobs = malloc(sqlite3_column_bytes(command, 0));
                blobs =(void*) sqlite3_column_blob(command, 0);
                
                UIImage* nn = [UIImage imageWithData:[NSData dataWithBytes:blobs length:sqlite3_column_bytes(command, 0)]];
                [data addObject:nn];
                
            }
            
            sqlite3_finalize(command);
            
            
        }else{
            printf("建立命令物件失敗！！");
        }
        
    }else{
        //////連線失敗！！do something you want
        printf("連線失敗！！");
    }
    
    
    
    sqlite3_close(connect);
    
    
    
    return data;
}




BOOL  has_this_guy(NSString* account, NSString* password){
    
    BOOL ok = NO;
    
  
    sqlite3* connect;
    
    //////先用OBjective C取得Bundle中的資料庫路徑
    //NSString* data_path_oc = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"sqlite"];
    NSString* temp = NSHomeDirectory();
    NSString* data_path_oc = [NSString stringWithFormat:@"%@%@",temp,@"/Documents/data.sqlite" ];

    //////轉成sqlite C的字串
    char* data_path_c = (char*)[data_path_oc UTF8String];
    
    int result = sqlite3_open(data_path_c, &connect);
    if(result ==SQLITE_OK){

        char* sql = "SELECT number FROM managers where name=? and password=?;" ;
        sqlite3_stmt* command;
        result = sqlite3_prepare(
                                 connect,
                                 sql,
                                 -1,
                                 &command,
                                 NULL
                                 );
        
        if(result ==SQLITE_OK){
           
            sqlite3_bind_text(command, 1, (char*)[account UTF8String], -1, NULL);
            sqlite3_bind_text(command, 2, (char*)[password UTF8String], -1, NULL);

             result = sqlite3_step(command);
             if(result == SQLITE_ROW){
             
                 ok=YES;
             
             }else{
             
                    printf("查無此資料！！");
             
             }
             
            
            sqlite3_finalize(command);
            
            
        }else{
            printf("建立命令物件失敗！！");
        }
        
    }else{
        //////連線失敗！！do something you want
        printf("連線失敗！！");
    }
    
    
    
    sqlite3_close(connect);
    
    
    
    
    
    
    
    return ok;
    
}
