//
//  DataBaseManager.h
//  ReportAIncident
//
//  Created by Vivek Sehrawat on 6/11/14.
//  Copyright (c) 2014 MA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseManager : NSObject

+(DataBaseManager *)database;

-(BOOL)reportIncidentWithCatName:(NSString *)categoryName LocationName:(NSString *)Loci Description:(NSString *)desc ImageUrl:(NSString *)ImgUrl isSync:(int)Syn; // zero= false


@end
