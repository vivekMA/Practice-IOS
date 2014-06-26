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
@property (nonatomic, copy) NSString *rating;


- (id)initWithLocation:(CLLocation *)location name:(NSString *)name ratingOfLocation:(NSString *)rating;

//- (NSString *)infoText;

@end
