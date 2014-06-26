//
//  MapViewController.h
//  iPhone-AR-Demo
//
//  Created by Vivek Sehrawat on 6/19/14.
//  Copyright (c) 2014 edrackham.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "ARKit.h"

@interface MapViewController : UIViewController<ARLocationDelegate,CLLocationManagerDelegate>{

}
@property (strong, nonatomic) CMMotionManager *motionManager;
//@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) NSMutableArray *marrlongArray;
@property (strong, nonatomic) NSMutableArray *marrlatArray;
@property (strong, nonatomic) NSMutableArray *marrNameArray;
@property (strong, nonatomic) NSMutableArray *marrRatingArray;

@property (strong, nonatomic) NSMutableArray *AllPlaces;


- (IBAction)agumentRealityButtonClicked:(id)sender;


@end
