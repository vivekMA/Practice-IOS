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
    
//    SharedData *shared=[SharedData sharedObj];
//    CLLocation *lastLocation = [shared.arrLocation lastObject];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:28.6100
                                                               longitude:77.2300
                                                                     zoom:15];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(28.6100, 77.2300);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
//   marker.icon = [UIImage imageNamed:@"food_map.png"];
    marker.map = mapView;
    self.view = mapView;
    mapView.delegate=self;
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
-(BOOL) mapView:(GMSMapView *) mapView didTapMarker:(GMSMarker *)marker
{
    NSLog(@"try");
    return YES;
}
- (void) mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
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
