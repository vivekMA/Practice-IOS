//
//  MapViewController.m
//  iPhone-AR-Demo
//
//  Created by Vivek Sehrawat on 6/19/14.
//  Copyright (c) 2014 edrackham.com. All rights reserved.
//

#import "MapViewController.h"
#import "SharedData.h"
#import "Place.h"
#import "PlaceAnnotation.h"
#import <GoogleMaps/GoogleMaps.h>


@interface MapViewController (){

ARViewController    *_arViewController;

}
@end

@implementation MapViewController

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
    // Do any additional setup after loading the view from its nib.
    
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 60.0f, 30.0f)];
    //    UIImage *backImage = [[UIImage imageNamed:@"back_button_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12.0f, 0, 12.0f)];
    //    [backButton setBackgroundImage:backImage  forState:UIControlStateNormal];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
//    
//    SharedData *shared=[SharedData sharedObj];
//     CLLocation *lastLocation = [shared.arrLocation lastObject];
//
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lastLocation.coordinate.latitude
//                                                            longitude:lastLocation.coordinate.longitude
//                                                                 zoom:15];
//    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//    
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(lastLocation.coordinate.latitude, lastLocation.coordinate.longitude);
////    marker.animated = YES; not found currently
//    marker.icon = [UIImage imageNamed:@"pin2"];
//    marker.map = mapView;
//    
//    self.view = mapView;
}

-(void) popBack {
    
    NSArray* tempVCA = [self.navigationController viewControllers];
    
    for(UIViewController *tempVC in tempVCA)
    {
        if([tempVC isKindOfClass:[ARViewController class]])
        {
            [tempVC removeFromParentViewController];
            
        }
    }
    self.navigationItem.leftBarButtonItem=nil;

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    
    [_mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading];
    SharedData *shared=[SharedData sharedObj];

    
    CLLocation *lastLocation = [shared.arrLocation lastObject];

    MKCoordinateSpan span = MKCoordinateSpanMake(0.14, 0.14);
    MKCoordinateRegion region = MKCoordinateRegionMake([lastLocation coordinate], span);
    [_mapView setRegion:region animated:YES];
    
    NSMutableArray *temp = [NSMutableArray array];

    for (int i=0; i<self.marrlongArray.count; i++) {
        // Add anonnation here
        
        CLLocationDegrees latdegree=[[self.marrlatArray objectAtIndex:i]doubleValue];
        CLLocationDegrees longdegree=[[self.marrlongArray objectAtIndex:i]doubleValue];

        CLLocation *location=[[ CLLocation alloc]initWithLatitude:latdegree longitude:longdegree];
        
        Place *currentPlace=[[Place alloc]initWithLocation:location name:[self.marrNameArray objectAtIndex:i]];
        
        [temp addObject:currentPlace];

        PlaceAnnotation *annotation = [[PlaceAnnotation alloc] initWithPlace:currentPlace];
        [_mapView addAnnotation:annotation];
        
    }

    self.navigationItem.hidesBackButton=YES;

    self.motionManager=[[CMMotionManager alloc]init];
    self.motionManager.accelerometerUpdateInterval=.2;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error){
        
        [self outputAccelertionData:accelerometerData.acceleration];
        
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[PlaceAnnotation class]])// if this is my custom pin class
    {
        PlaceAnnotation *mylocation=(PlaceAnnotation *)annotation;
        
        MKAnnotationView *annonationView=[self.mapView dequeueReusableAnnotationViewWithIdentifier:@"MyCustomAnnonation"];
        
        if (annonationView==nil){
            annonationView=mylocation.annotationView;
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)] ;
            lbl.backgroundColor = [UIColor blackColor];
            lbl.textColor = [UIColor whiteColor];
            lbl.alpha = 0.5;
            lbl.tag = 42;
            [annonationView addSubview:lbl];
            lbl.text=@"delhi";
            //Following lets the callout still work if you tap on the label...
            annonationView.canShowCallout = YES;
            annonationView.frame = lbl.frame;
            
//            annonationView.image=[UIImage imageNamed:@"pin2.png"];
        }
        else{
            annonationView.annotation=annotation;
            

        }
        return annonationView;
    }
    else
        return nil;
}

- (void)viewDidAppear:(BOOL)animated{
    _arViewController = nil;
}
-(void)viewWillDisappear:(BOOL)animated{
    
    self.motionManager=nil;

}
-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    
    BOOL X_axiz=  [self float:acceleration.x between:-.75 and:.75];
    BOOL Z_axiz=  [self float:acceleration.z between:-.72 and:.70];
    
    
    if (X_axiz & Z_axiz) { // show Map
        
    }
    else{ // AR
       
        [self.motionManager stopAccelerometerUpdates];
        
        //show map
        SharedData *shared=[SharedData sharedObj];
       
        if(shared.MapViewFirst){ //if map first loaded push or present
            
            NSArray *viewControlles = [self.navigationController viewControllers];
            
            for (int i = 0 ; i <viewControlles.count; i++){
                if ([_arViewController isKindOfClass:[viewControlles objectAtIndex:i]]) {
                    //Execute your code
                    
                    [_arViewController removeFromParentViewController];
                    
                }
            }
            _arViewController = [[ARViewController alloc] initWithDelegate:self];
            _arViewController.showsCloseButton = false;
            [_arViewController setHidesBottomBarWhenPushed:YES];
            [_arViewController setRadarRange:400000.0];
            [_arViewController setOnlyShowItemsWithinRadarRange:YES];
            

            [self.navigationController pushViewController:_arViewController animated:NO];

        }else{ // dissmiss or pop here
            
            [self.navigationController popViewControllerAnimated:NO];
        }

//        [self dismissViewControllerAnimated:NO completion:nil];
        
    }
    
}
//- (NSMutableArray *)geoLocations{
//    
//    SharedData *shared=[SharedData sharedObj];
//   return  shared.marrLatLongArray;
//
//}
- (NSMutableArray *)geoLocations{
    
    NSMutableArray *locationArray ;
    locationArray = [[NSMutableArray alloc] init];
    ARGeoCoordinate *tempCoordinate;
    CLLocation       *tempLocation;
    
    for (int i=0; i<self.marrNameArray.count; i++) {
        
        tempLocation = [[CLLocation alloc] initWithLatitude:[[self.marrlatArray objectAtIndex:i] floatValue] longitude:[[self.marrlongArray objectAtIndex:i] floatValue]];
        tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation locationTitle:[self.marrNameArray objectAtIndex:i]];
        
        tempCoordinate.inclination = 0.8;
        [locationArray addObject:tempCoordinate];
        
    }
    
    
    //    NSLog(@"%lu,%lu,%lu",(unsigned long)[Longarray count],(unsigned long)[Latarray count],(unsigned long)[namearray count]);
    //      NSLog(@"%lu",(unsigned long)[locationArray count]);
    //
    //          NSLog(@"%@",locationArray);
    

    
    return locationArray;
}



- (BOOL)float:(float)aFloat between:(float)minValue and:(float)maxValue {
   
    if (aFloat >= minValue && aFloat <= maxValue) {
        return YES;
    } else {
        return NO;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
