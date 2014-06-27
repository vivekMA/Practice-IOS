//
//  AppDataBase.m
//  Lavasa
//
//  Created by Vivek Sehrawat on 6/27/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "AppDataBase.h"
#import "FMDatabase.h"


@implementation AppDataBase


static AppDataBase *_database;

+(AppDataBase *)database{
    
    if (_database==nil) {
        
        _database=[[AppDataBase alloc]init];
    }
    return _database;
}
-(id)init{
    
    if (self = [super init]) {
        
        NSFileManager *fileManager=[NSFileManager defaultManager];
        NSString *filePath=[self databasePath];
        if (![fileManager fileExistsAtPath:filePath]) {
            NSString *sqLiteDb=[[NSBundle mainBundle]pathForResource:@"User" ofType:@"db"];
            [fileManager copyItemAtPath:sqLiteDb toPath:filePath error:NULL];
        }
    }
    return self;
}

-(NSString *)databasePath{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucmentsDirectory=paths[0];
    return [doucmentsDirectory stringByAppendingPathComponent:@"User.db"];
}

-(BOOL)reportIncidentWithCatName:(NSString *)categoryName LocationName:(NSString *)Loci Description:(NSString *)desc ImageUrl:(NSString *)ImgUrl  isSync:(int)Syn{
    
    FMDatabase *database=[FMDatabase databaseWithPath:[self databasePath]];
    [database open];
    
    NSString *query=[NSString stringWithFormat:@"INSERT INTO tbl_reportincident (cat_name,user_location,description,img_url,is_synced) VALUES ('%@','%@','%@','%@',%d)",categoryName,Loci,desc,ImgUrl,Syn];
    
    NSLog(@"this is the  query=====%@",query);
    
    BOOL success= [database executeUpdate:query];
    
    NSLog(success ? @"Inserted" : @"Failed");
    
    return success;
    
}


@end
