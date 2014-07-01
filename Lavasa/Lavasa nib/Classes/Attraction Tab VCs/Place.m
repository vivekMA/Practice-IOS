//
//  Place.m
//  MapAR
//
//  Created by Vivek Sehrawat on 6/20/14.
//  Copyright (c) 2014 edrackham.com. All rights reserved.
//

#import "Place.h"

@implementation Place




- (id)initWithLocation:(CLLocation *)location name:(NSString *)name ratingOfLocation:(NSString *)rating address:(NSString *)address placeId:(NSString *)placeId{
	if((self = [super init])) {
		_location = location;
		_placeName = [name copy];
        _rating=[rating copy];
        _address = [address copy];
        _placeID=[placeId copy];

	}
	
	return self;
}
//
//- (NSString *)infoText {
//	return [NSString stringWithFormat:@"Name:%@\nAddress:%@\nPhone:%@\nWeb:%@", _placeName, _address, _phoneNumber, _website];
//}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ Name:%@, location:%@", [super description], _placeName, _location];
}

@end
