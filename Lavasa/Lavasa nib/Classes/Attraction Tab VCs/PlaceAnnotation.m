//
//  PlaceAnnotation.m
//  MapAR
//
//  Created by Vivek Sehrawat on 6/20/14.
//  Copyright (c) 2014 edrackham.com. All rights reserved.
//

#import "PlaceAnnotation.h"
#import "Place.h"

@interface PlaceAnnotation ()

@property (nonatomic, strong) Place *place;

@end

@implementation PlaceAnnotation

- (id)initWithPlace:(Place *)place {
	if((self = [super init])) {
		_place = place;
        
	}
	return self;
}

- (CLLocationCoordinate2D)coordinate {
	return [_place location].coordinate;
}

- (NSString *)title {
	return [_place placeName];
}
-(MKAnnotationView *)annotationView{
    
    MKAnnotationView *annotationView=[[MKAnnotationView alloc]initWithAnnotation:self reuseIdentifier:@"MyCustomAnnonation"];
    annotationView.enabled=YES;
    annotationView.image=_image;
    
    return annotationView;

}

@end
