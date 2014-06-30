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
            NSString *sqLiteDb=[[NSBundle mainBundle]pathForResource:@"lavasa_web_service" ofType:@"sqlite"];
            [fileManager copyItemAtPath:sqLiteDb toPath:filePath error:NULL];
        }
    }
    return self;
}
-(NSString *)databasePath{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucmentsDirectory=paths[0];
    return [doucmentsDirectory stringByAppendingPathComponent:@"lavasa_web_service.sqlite"];
}

//PlanVC Method

-(FMResultSet *)PlanCatDetail:(NSString *)Keyword {
    
    FMDatabase *database=[FMDatabase databaseWithPath:[self databasePath]];
    [database open];
    
    NSString *query;
    if ([Keyword isEqualToString:@"4"]) {
         query=[NSString stringWithFormat:@"select package.* from package inner join package_keyword on package.id=package_keyword.package_id " ];
    }else
    {
       query=[NSString stringWithFormat:@"select package.* from package inner join package_keyword on package.id=package_keyword.package_id  where package_keyword.[keyword_id]=%@",Keyword ];
        
    }
    
  

    FMResultSet *results;
    results = [database executeQuery:query];
    return results;
}

//PlanDetailVC Method

-(FMResultSet *)PlanDetailwithPackageID:(NSString *)PackageId {
    
    FMDatabase *database=[FMDatabase databaseWithPath:[self databasePath]];
    [database open];
    
    NSString *query=[NSString stringWithFormat:@"select place.* from package_itinerary inner join itinerary on package_itinerary.itinerary_id=itinerary.id inner join place on itinerary.place_id=place.id where package_itinerary.[package_id]=%@",PackageId ];
    
  
    
    FMResultSet *results;
    results = [database executeQuery:query];
    return results;
}


@end
