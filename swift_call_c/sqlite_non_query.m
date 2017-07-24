//
//  sqlite_non_query.m
//  swift_call_c
//
//  Created by john2 on 2017/7/5.
//  Copyright © 2017年 haha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <sqlite3.h>

BOOL insert_new_record(NSInteger number,NSString* name, NSInteger score, UIImage* picture){
    
    
    NSLog(@"mark%d", 1);
    BOOL data = NO;
    
    sqlite3* connect;
    //NSString* data_path_oc = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"sqlite"];
    NSString* temp = NSHomeDirectory();
    NSString* data_path_oc = [NSString stringWithFormat:@"%@%@",temp,@"/Documents/data.sqlite" ];
    char* data_path_c = (char*)[data_path_oc UTF8String];
    int result = sqlite3_open(data_path_c, &connect);
    if(result ==SQLITE_OK){
        NSLog(@"mark%d", 2);
        char* sql = "insert into students(number,name,score,picture)values(?,?,?,?)" ;
        sqlite3_stmt* command;
        result = sqlite3_prepare(
                                 connect,
                                 sql,
                                 -1,
                                 &command,
                                 NULL
                                 );
        if(result ==SQLITE_OK){
            NSLog(@"mark%d", 3);
            sqlite3_bind_int(command, 1, (int)number);
            sqlite3_bind_text(command, 2, (char*)[name UTF8String], -1, NULL);
            sqlite3_bind_int(command, 3, (int)score);

            //NSData* da = UIImagePNGRepresentation(picture); UIImageJPEGRepresentation
            NSData* da = UIImageJPEGRepresentation(picture, 0.5);
            long count = da.length / sizeof(UInt8);
            char* array =(char*) da.bytes ;
          
            sqlite3_bind_blob(command, 4, array, (int)count, NULL);
            
            if (sqlite3_step(command)==SQLITE_DONE){
                NSLog(@"mark%d", 4);
                data= YES;
                
            }
            
            sqlite3_finalize(command);
            
            
        }else{
            printf("建立命令物件失敗！！");
        }
        
    }else{
        //////連線失敗！！do something you want
        printf("連線失敗！！");
    }
    
    NSLog(@"mark%d", 5);
    
    sqlite3_close(connect);
    
    
    
    
    
    return data;

    
    
}
