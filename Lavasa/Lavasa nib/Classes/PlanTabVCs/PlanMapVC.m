//
//  PlanMapVC.m
//  Lavasa
//
//  Created by Vivek Sehrawat on 7/2/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "PlanMapVC.h"

#import "UIApplication+AppDimension.h"
#import "SharedData.h"
#import "Place.h"
#import "PlacesLoader.h"
#import "AppConstant.h"

@interface PlanMapVC ()
// AIzaSyAzAYkAVXp2GkQeCEY1GLyQw8N0XfNmsVo key
@end

@implementation PlanMapVC
@synthesize OverLayView,latLongitudes;

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
    ShowOverLay=FALSE;

    PlaceLocation= [[NSMutableArray alloc]init];
    GMSCameraPosition *camera;
    
    CLLocationDegrees lat=[[[latLongitudes objectAtIndex:0] objectForKey:@"lat"] doubleValue];
    CLLocationDegrees lng=[[[latLongitudes objectAtIndex:0] objectForKey:@"lng"] doubleValue ];
        
    camera = [GMSCameraPosition cameraWithLatitude:lat longitude:lng zoom:12];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.delegate=self;

    
    for (NSDictionary *dict in latLongitudes) {
        
        CLLocationDegrees lat=[[dict objectForKey:@"lat"]doubleValue];
        CLLocationDegrees lng=[[dict objectForKey:@"lng"]doubleValue];
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
        NSLog(@"%@",location);

        NSString *locationName=[dict objectForKey:@"name"];
        NSString *rating =[dict objectForKey:@"overall_rating"];
        NSString *address=[dict objectForKey:@"address"];
        NSString *placeId=[dict objectForKey:@"id"];
        
        Place *currentPlace = [[Place alloc] initWithLocation:location name:locationName ratingOfLocation:rating address:address placeId:placeId];
        [PlaceLocation addObject:currentPlace.location];
        
        
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(lat, lng);
        
//        GMSMarker *marker = [GMSMarker markerWithPosition:position];
//        //   marker.icon = [UIImage imageNamed:@"food_map.png"];
//        marker.map = mapView;
//        marker.title=currentPlace.placeName;
//        marker.userData=currentPlace;
//        self.view = mapView;
//        mapView.delegate=self;
        
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = position;
        marker.userData=currentPlace;
        marker.title=currentPlace.placeName;
        marker.appearAnimation=TRUE;
        marker.icon = [UIImage imageNamed:@"food_map.png"];
        
        marker.map = mapView;
        self.view = mapView;

    }
  
    CGSize screenSize=[UIApplication currentSize];
    self.OverLayView.frame=CGRectMake(0, screenSize.height+50, screenSize.width, 200);
    [mapView addSubview:OverLayView];
    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGSize screenSize=[UIApplication sizeInOrientation:toInterfaceOrientation];
    
    if (ShowOverLay) {
        self.OverLayView.frame=CGRectMake(0, screenSize.height-170, screenSize.width, 200);
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
    
    Place *place=marker.userData;
    
    self.ratingView.rating=[place.rating floatValue];
    self.nameLbl.text=place.placeName;
    self.addressLbl.text=place.address;
    
    markerPosition=marker.position;
    
    if (!ShowOverLay) {
        CGSize screenSize=[UIApplication currentSize];
        [UIView animateWithDuration:.3 animations:^{
            self.OverLayView.frame=CGRectMake(0, screenSize.height-170, screenSize.width, 200);
        }completion:^(BOOL finished){
            ShowOverLay=TRUE;
        }];
    }
    else{
        
        CGSize screenSize=[UIApplication currentSize];
        [UIView animateWithDuration:.3 animations:^{
            self.OverLayView.frame=CGRectMake(0, screenSize.height+50, screenSize.width, 200);
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
    return NO;
}
- (void) mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
    
    if (ShowOverLay) {
        CGSize screenSize=[UIApplication currentSize];
        [UIView animateWithDuration:.3 animations:^{
            self.OverLayView.frame=CGRectMake(0, screenSize.height+50, screenSize.width, 200);
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
    
    CLLocation *location=[[CLLocation alloc]initWithLatitude:markerPosition.latitude longitude:markerPosition.longitude];
    
    NSLog(@" %@ ",location);
    
    objhud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    objhud.labelText=@"Loading...";
    
    [[PlacesLoader sharedInstance]loadPOIsForLocation:location radius:500 type:@"establishment" successHandler:^(NSDictionary *response){
        
        NSLog(@"Response: %@", response);
        
        if([[response objectForKey:@"status"] isEqualToString:@"OK"]) {
            
            id places = [response objectForKey:@"results"];
            
            
            if([places isKindOfClass:[NSArray class]]) {
                
                for(NSDictionary *resultsDict in places) {
                    
                    
                    
                    CLLocation *location = [[CLLocation alloc] initWithLatitude:[[resultsDict valueForKeyPath:kLatiudeKeypath] floatValue] longitude:[[resultsDict valueForKeyPath:kLongitudeKeypath] floatValue]];
                    
                    
                    
                    //
                    NSString *rating=@"";
					
                    if ([resultsDict objectForKey:kRating]){
                        
                        
                        
                        rating= [resultsDict objectForKey:kRating];
                    }
                    
                    NSString *locationName=[resultsDict objectForKey:kNameKey];
                    NSString *address=[resultsDict objectForKey:kAddressKey];
                    NSString *placeId=[resultsDict objectForKey:kPlaceId];
                    
                    Place *currentPlace = [[Place alloc] initWithLocation:location name:locationName ratingOfLocation:rating address:address placeId:placeId] ;
                    
                    CLLocationCoordinate2D position = CLLocationCoordinate2DMake([[resultsDict valueForKeyPath:kLatiudeKeypath]floatValue] , [[resultsDict valueForKeyPath:kLongitudeKeypath] floatValue]);
                    
                    if (![PlaceLocation containsObject:currentPlace.placeID]) {
                        // this is to check the duplicate places
                        
                        GMSMarker *marker = [[GMSMarker alloc] init];
                        marker.position = position;
                        marker.userData=currentPlace;
                        marker.title=currentPlace.placeName;
                        
                        marker.appearAnimation=TRUE;
                        marker.icon = [UIImage imageNamed:@"food_map.png"];
                        
                        marker.map = mapView;
                        self.view = mapView;
                        [PlaceLocation addObject:currentPlace.placeID];
                        
                    }
                    //                    Place *currentPlace = [[Place alloc]initWithLocation:location2 name:[resultsDict objectForKey:kNameKey] ratingOfLocation:rating address:[resultsDict objectForKey:kAddressKey]];
                    
                    //                    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:[[resultsDict valueForKeyPath:kLatiudeKeypath] floatValue] longitude:[[resultsDict valueForKeyPath:kLongitudeKeypath] floatValue]];
                    //                    NSString *rating=@"";
                    //
                    //                    if ([resultsDict objectForKey:kRating]){
                    //
                    //                        rating= [resultsDict objectForKey:kRating];
                    //                    }
                    //                    Place *currentPlace = [[Place alloc]initWithLocation:location2 name:[resultsDict objectForKey:kNameKey] ratingOfLocation:rating];
                    //
                    //                    [Places addObject:currentPlace];
                }
            }
            else{
                NSLog(@"?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????");
            }
            objhud.hidden=YES;
            if (ShowOverLay) {
                CGSize screenSize=[UIApplication currentSize];
                [UIView animateWithDuration:.3 animations:^{
                    self.OverLayView.frame=CGRectMake(0, screenSize.height+50, screenSize.width, 200);
                }completion:^(BOOL finished){
                    ShowOverLay=FALSE;
                }];
            }
            
        }
    }errorHandler:^(NSError *error){
        NSLog(@"Error: %@", error);
    }];
    
    
    
    
    
    
}

@end
