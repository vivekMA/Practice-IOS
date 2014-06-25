//
//  Place.h
//  MapAR
//
//  Created by Vivek Sehrawat on 6/20/14.
//  Copyright (c) 2014 edrackham.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLLocation;

@interface Place : NSObject

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, copy) NSString *placeName;


- (id)initWithLocation:(CLLocation *)location name:(NSString *)name;

//- (NSString *)infoText;

@end
