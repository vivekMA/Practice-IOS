//
//  AppDataBase.h
//  Lavasa
//
//  Created by Vivek Sehrawat on 6/27/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppDataBase : NSObject



+(AppDataBase *)database;

-(BOOL)reportIncidentWithCatName:(NSString *)categoryName LocationName:(NSString *)Loci Description:(NSString *)desc ImageUrl:(NSString *)ImgUrl isSync:(int)Syn; // zero= false



@end
