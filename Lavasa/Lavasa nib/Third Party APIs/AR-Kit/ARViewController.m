//
//  ARViewController.m
//  ARKitDemo
//
//  Modified by Niels W Hansen on 12/31/11.
//  Modified by Ed Rackham (a1phanumeric) 2013
//

#import "ARViewController.h"
#import "AugmentedRealityController.h"
#import "GEOLocations.h"
#import "MarkerView.h"
#import "MapViewController.h"
#import "SharedData.h"

@implementation ARViewController{
    AugmentedRealityController *_agController;
}

@synthesize delegate;

- (id)initWithDelegate:(id<ARLocationDelegate>)aDelegate{
	
   
//    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 60.0f, 30.0f)];
//    //    UIImage *backImage = [[UIImage imageNamed:@"back_button_normal.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12.0f, 0, 12.0f)];
//    //    [backButton setBackgroundImage:backImage  forState:UIControlStateNormal];
//    [backButton setTitle:@"Back" forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    self.navigationItem.leftBarButtonItem = backButtonItem;
    
	[self setDelegate:aDelegate];
	
	if (!(self = [super init])){
		return nil;
	}
    
	[self setWantsFullScreenLayout:NO];
    
    // Defaults
    _debugMode                      = NO;
    _scaleViewsBasedOnDistance      = YES;
    _minimumScaleFactor             = 0.5;
    _rotateViewsBasedOnPerspective  = YES;
    _showsRadar                     = NO;
    _showsCloseButton               = NO;
    _radarRange                     = 20.0;
    _onlyShowItemsWithinRadarRange  = NO;
    
    // Create ARC
    _agController = [[AugmentedRealityController alloc] initWithViewController:self withDelgate:self];
	
    [_agController setShowsRadar:_showsRadar];
    [_agController setRadarRange:_radarRange];
	[_agController setScaleViewsBasedOnDistance:_scaleViewsBasedOnDistance];
	[_agController setMinimumScaleFactor:_minimumScaleFactor];
	[_agController setRotateViewsBasedOnPerspective:_rotateViewsBasedOnPerspective];
    [_agController setOnlyShowItemsWithinRadarRange:_onlyShowItemsWithinRadarRange];
    
    GEOLocations *locations = [[GEOLocations alloc] initWithDelegate:delegate];
	
	if([[locations returnLocations] count] > 0){
		for (ARGeoCoordinate *coordinate in [locations returnLocations]){
			MarkerView *cv = [[MarkerView alloc] initForCoordinate:coordinate withDelgate:self allowsCallout:YES];
            [coordinate setDisplayView:cv];
			[_agController addCoordinate:coordinate];
		}
	}
    
    [self.view setAutoresizesSubviews:YES];
    
 	return self;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.motionManager=nil;
}
//- (void)closeButtonClicked:(id)sender {
//    _agController = nil;
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
}

-(void) popBack {
    
    
    
//    NSArray* tempVCA = [self.navigationController viewControllers];
//    
//    for(UIViewController *tempVC in tempVCA)
//    {
//        if([tempVC isKindOfClass:[MapViewController class]])
//        {
//            [tempVC removeFromParentViewController];
//            
//            //            [tempNavBarItems removeFromParentViewController];
//        }
//    }
//    self.navigationItem.leftBarButtonItem=nil;
//
//    
//    
//    [self.navigationController popViewControllerAnimated:YES];
}
//- (BOOL)shouldAutorotate
//{
//    return NO;
//}
//
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
//}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
//    self.navigationItem.hidesBackButton=YES;
//
//    
//    self.motionManager=[[CMMotionManager alloc]init];
//    self.motionManager.accelerometerUpdateInterval=.2;
//    
//    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error){
//        
//        
//        [self outputAccelertionData:accelerometerData.acceleration];
//        
//        if (error) {
//            NSLog(@"%@",error);
//        }
//        
//    }];
    
    if(_showsCloseButton == YES) {
//        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
//        
//        [closeBtn setTitle:@"Close" forState:UIControlStateNormal];
//        [closeBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
//        [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [closeBtn.titleLabel setShadowColor:[UIColor colorWithWhite:0.1 alpha:1.0]];
//        [closeBtn.titleLabel setShadowOffset:CGSizeMake(0, -1)];
//        [closeBtn setBackgroundColor:[UIColor colorWithWhite:0.3 alpha:1.0]];
//        [closeBtn addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        [[self view] addSubview:closeBtn];
    }
}
//-(void)outputAccelertionData:(CMAcceleration)acceleration
//{
////    NSLog(@"1");
//
//    
//    BOOL X_axiz=  [self float:acceleration.x between:-.75 and:.75];
//    BOOL Z_axiz=  [self float:acceleration.x between:-.72 and:.70];
//    
//    if (X_axiz & Z_axiz) {
//        [self.motionManager stopAccelerometerUpdates];
//
//
//        //show map
//        SharedData *shared=[SharedData sharedObj];
//        if(shared.MapViewFirst){ // disssmiss
//            
//            [self.navigationController popViewControllerAnimated:NO];
//            
//        }else{
//        
//            MapViewController *map=[[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
//
//            NSArray *viewControlles = [self.navigationController viewControllers];
//            
//            for (int i = 0 ; i <viewControlles.count; i++){
//                if ([map isKindOfClass:[viewControlles objectAtIndex:i]]) {
//                    //Execute your code
//                    
//                    [map removeFromParentViewController];
//
//                }
//            }
//            
//            [self.navigationController pushViewController:map animated:NO];
//
//        }
//    }
//    else{
//        // do nothing because its already AR
//    }
//}
//
//- (BOOL)float:(float)aFloat between:(float)minValue and:(float)maxValue {
//    if (aFloat >= minValue && aFloat <= maxValue) {
//        return YES;
//    } else {
//        return NO;
//    }
//}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//	return YES;
//}


- (void)didTapMarker:(ARGeoCoordinate *)coordinate {
    NSLog(@"delegate worked click on %@", [coordinate title]);
    [delegate locationClicked:coordinate];
    
}

- (void)didUpdateHeading:(CLHeading *)newHeading {
    //NSLog(@"Heading Updated");
}
- (void)didUpdateLocation:(CLLocation *)newLocation {
    //NSLog(@"Location Updated");
}
- (void)didUpdateOrientation:(UIDeviceOrientation)orientation {
   /*NSLog(@"Orientation Updated");
    
    if(orientation == UIDeviceOrientationPortrait)
        NSLog(@"Portrait");
    */
}

#pragma mark - Custom Setters
- (void)setDebugMode:(BOOL)debugMode{
    _debugMode = debugMode;
    [_agController setDebugMode:_debugMode];
}

- (void)setShowsRadar:(BOOL)showsRadar{
    _showsRadar = showsRadar;
    [_agController setShowsRadar:_showsRadar];
}

- (void)setScaleViewsBasedOnDistance:(BOOL)scaleViewsBasedOnDistance{
    _scaleViewsBasedOnDistance = scaleViewsBasedOnDistance;
    [_agController setScaleViewsBasedOnDistance:_scaleViewsBasedOnDistance];
}

- (void)setMinimumScaleFactor:(float)minimumScaleFactor{
    _minimumScaleFactor = minimumScaleFactor;
    [_agController setMinimumScaleFactor:_minimumScaleFactor];
}

- (void)setRotateViewsBasedOnPerspective:(BOOL)rotateViewsBasedOnPerspective{
    _rotateViewsBasedOnPerspective = rotateViewsBasedOnPerspective;
    [_agController setRotateViewsBasedOnPerspective:_rotateViewsBasedOnPerspective];
}

- (void)setRadarPointColour:(UIColor *)radarPointColour{
    _radarPointColour = radarPointColour;
    [_agController.radarView setPointColour:_radarPointColour];
}

- (void)setRadarBackgroundColour:(UIColor *)radarBackgroundColour{
    _radarBackgroundColour = radarBackgroundColour;
    [_agController.radarView setRadarBackgroundColour:_radarBackgroundColour];
}

- (void)setRadarViewportColour:(UIColor *)radarViewportColour{
    _radarViewportColour = radarViewportColour;
    [_agController.radarViewPort setViewportColour:_radarViewportColour];
}

- (void)setRadarRange:(float)radarRange{
    _radarRange = radarRange;
    [_agController setRadarRange:_radarRange];
}

- (void)setOnlyShowItemsWithinRadarRange:(BOOL)onlyShowItemsWithinRadarRange{
    _onlyShowItemsWithinRadarRange = onlyShowItemsWithinRadarRange;
    [_agController setOnlyShowItemsWithinRadarRange:_onlyShowItemsWithinRadarRange];
}


#pragma mark - View Cleanup
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	_agController = nil;
}

@end
