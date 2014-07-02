//
//  PlanMapVC.h
//  Lavasa
//
//  Created by Vivek Sehrawat on 7/2/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "DLStarRatingControl.h"
#import "MBProgressHUD.h"

@interface PlanMapVC : UIViewController<GMSMapViewDelegate>{
    
    GMSMapView *mapView ;
    BOOL ShowOverLay;
    CLLocationCoordinate2D markerPosition;
    MBProgressHUD *objhud;
    NSMutableArray *PlaceLocation;
}
@property (strong, nonatomic) IBOutlet UIView *OverLayView;
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *addressLbl;
@property (strong, nonatomic) IBOutlet DLStarRatingControl *ratingView;

- (IBAction)getMeThere:(id)sender;
- (IBAction)nearByPlaces:(id)sender;


@end
