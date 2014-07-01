//
//  MapDetailVC.m
//  Lavasa
//
//  Created by Vivek Sehrawat on 6/27/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "MapDetailVC.h"
#import "UIApplication+AppDimension.h"

@interface MapDetailVC ()

@end

@implementation MapDetailVC
@synthesize OverLayView;

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
                                                                     zoom:13];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
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
    
    ShowOverLay=FALSE;
    CGSize screenSize=[UIApplication currentSize];
    self.OverLayView.frame=CGRectMake(0, screenSize.height, screenSize.width, 200);
    [mapView addSubview:OverLayView];

}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGSize screenSize=[UIApplication sizeInOrientation:toInterfaceOrientation];
    
    if (ShowOverLay) {
        self.OverLayView.frame=CGRectMake(0, screenSize.height-235, screenSize.width, 200);
    }

    
//    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
//    
//    
//    }else{
//        
//    }
}

-(BOOL) mapView:(GMSMapView *) mapView didTapMarker:(GMSMarker *)marker
{
    if (!ShowOverLay) {
        CGSize screenSize=[UIApplication currentSize];
        [UIView animateWithDuration:.3 animations:^{
            self.OverLayView.frame=CGRectMake(0, screenSize.height-235, screenSize.width, 200);
        }completion:^(BOOL finished){
            ShowOverLay=TRUE;
        }];
    }
    else{
        
        CGSize screenSize=[UIApplication currentSize];
        [UIView animateWithDuration:.3 animations:^{
            self.OverLayView.frame=CGRectMake(0, screenSize.height, screenSize.width, 200);
        }completion:^(BOOL finished){
            ShowOverLay=FALSE;
        }];
        
    }
    
    
    
//    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(28.6100, 77.2300);
    
//    if ([marker.position == position]) {
//        
//    }

    
//    CGRect screenRect=[self currentScreenBoundsDependOnOrientation];
//    //    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    CGFloat screenHeight = screenRect.size.height;
//    self.OverLayView.frame=CGRectMake(0, screenHeight-200, screenWidth, 200);

    NSLog(@"try");
    return YES;
}
- (void) mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
    
    if (ShowOverLay) {
        CGSize screenSize=[UIApplication currentSize];
        [UIView animateWithDuration:.3 animations:^{
            self.OverLayView.frame=CGRectMake(0, screenSize.height, screenSize.width, 200);
        }completion:^(BOOL finished){
            ShowOverLay=FALSE;
        }];
    }
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

- (IBAction)getMeThere:(id)sender {
}

- (IBAction)nearByPlaces:(id)sender {
}
@end
