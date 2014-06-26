//
//  PlacesLoader.h
//  Lavasa
//
//  Created by Vivek Sehrawat on 6/26/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

typedef void (^SuccessHandler)(NSDictionary *responseDict);
typedef void (^ErrorHandler)(NSError *error);

@class Place;

@interface PlacesLoader : NSObject

+(PlacesLoader *)sharedInstance;

-(void)loadPOIsForLocation:(CLLocation *)location radius:(int)radius type:(NSString *)type successHandler:(SuccessHandler)handler errorHandler:(ErrorHandler)errorHandler;

//-(void)loadDetailInformation:(Place *)location successHandler:(SuccessHandler)handler errorHandler:(ErrorHandler)errorHandler;

@end
