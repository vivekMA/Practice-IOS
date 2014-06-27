//
//  MapDetailVC.m
//  Lavasa
//
//  Created by Vivek Sehrawat on 6/27/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "MapDetailVC.h"

@interface MapDetailVC ()

@end

@implementation MapDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lastLocation.coordinate.latitude
    //                                                            longitude:lastLocation.coordinate.longitude
    //                                                                 zoom:15];
    //    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    //
    //    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude);
    //    GMSMarker *marker = [GMSMarker markerWithPosition:position];
    //    marker.title = @"I am here";
    //    marker.map = mapView;
    //
    //    for (int i=0; i<self.AllPlaces.count; i++) {
    //
    //        Place *place=[self.AllPlaces objectAtIndex:i];
    //
    //        GMSMarker *marker = [[GMSMarker alloc] init];
    //        marker.position = CLLocationCoordinate2DMake(place.location.coordinate.latitude, place.location.coordinate.longitude);
    //        marker.icon = [UIImage imageNamed:@"food_map.png"];
    //        marker.map = mapView;
    //        self.view = mapView;
    //
    //    }
    //
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
