//
//  PlaceAnnotation.h
//  MapAR
//
//  Created by Vivek Sehrawat on 6/20/14.
//  Copyright (c) 2014 edrackham.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@class Place;

@interface PlaceAnnotation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, retain) UIImage *image;


- (id)initWithPlace:(Place *)place;

-(MKAnnotationView *)annotationView;

@end
