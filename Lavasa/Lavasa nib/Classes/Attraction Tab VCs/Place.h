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
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *placeID;



- (id)initWithLocation:(CLLocation *)location name:(NSString *)name ratingOfLocation:(NSString *)rating address:(NSString *)address placeId:(NSString *)placeId;





//- (NSString *)infoText;

@end
