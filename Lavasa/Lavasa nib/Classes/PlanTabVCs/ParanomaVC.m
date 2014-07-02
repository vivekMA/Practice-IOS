//
//  ParanomaVC.m
//  Lavasa
//
//  Created by Vivek Yadav on 7/2/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "ParanomaVC.h"


#define kInitialHeading 80
#define kInitialPitch 83.67
#define kDefaultFOV 120
#define kOverlayFrameInterval 2
#define kInitialZoom 1

static CLLocationCoordinate2D kPanoramaNear = {28.576277,77.242502};


@interface ParanomaVC ()
{
  //  SVPDPanoramaOverlayView *panoramaOverlayView_;
    GMSPanoramaView *panoramaView_;
    CADisplayLink *displayLink_;
    BOOL panoramaConfigured_;
    BOOL overlayUpdateNeeded_;
}
@end

@implementation ParanomaVC

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
 
    
      self.navigationController.navigationBar.hidden=NO;
    // the top level view containing our panorama and panorama overlay
//    UIView* topView = [[UIView alloc] initWithFrame:sel];
//    topView.backgroundColor = [UIColor clearColor];
//    topView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    // initialize the panorama view
    panoramaView_ = [GMSPanoramaView panoramaWithFrame:self.view.bounds nearCoordinate:kPanoramaNear];
    
    panoramaView_.backgroundColor = [UIColor grayColor];
    panoramaView_.delegate = self;
    panoramaView_.navigationGestures=YES;
    panoramaView_.navigationLinksHidden = NO;
    panoramaView_.zoomGestures=YES;
    panoramaView_.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
      //
//    self.view = topView;
    [self.view addSubview:panoramaView_];
    
    
    [panoramaView_ moveToPanoramaID:@"bYwuoQjjWHkAAAQWrmt01g"];

}
- (void) viewWillAppear:(BOOL)animated {
    // create a display link which will sync a method call with the view refresh
    displayLink_ = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkEvent:)];
    
    // set the frame interval; a value of 2 means we are firing every other frame, approx 30fps, tune to taste
    displayLink_.frameInterval = kOverlayFrameInterval;
    
    [displayLink_ addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
     self.tabBarController.tabBar.hidden=YES;
}

- (void) viewWillDisappear:(BOOL)animated {
    [displayLink_ invalidate];
      self.tabBarController.tabBar.hidden=NO;
}

- (void) displayLinkEvent:(CADisplayLink*)sender {
    // only request a sync when something has changed
    if (overlayUpdateNeeded_) {
//        [panoramaOverlayView_ setNeedsDisplay];
//        overlayUpdateNeeded_ = NO;
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    if (panoramaConfigured_) {
        // refresh camera as it seems that FOV changes when the view is rotated - TODO: eliminate the need for this
        panoramaView_.camera = [GMSPanoramaCamera cameraWithOrientation:panoramaView_.camera.orientation zoom:panoramaView_.camera.zoom+0.0001 FOV:panoramaView_.camera.FOV];
    }
}

#pragma mark - GMSPanoramaDelegate
- (void)panoramaView:(GMSPanoramaView *)panoramaView didMoveCamera:(GMSPanoramaCamera *)camera {
    // camera moved, so we need to update our overlay
//    [panoramaOverlayView_ updateWithPanoramaView:panoramaView];
    
    // make sure when the next displayLink event fires that we redraw the overlay
    overlayUpdateNeeded_ = YES;
}

- (void)panoramaView:(GMSPanoramaView *)view didMoveToPanorama:(GMSPanorama *)panorama {
    if (!panoramaConfigured_) {
        // create our intial camera with our default FOV
        // since 1.4.1 the FOV is accessible so we can create some cool fisheye effects or remove distortion with a smaller FOV
        panoramaView_.camera = [GMSPanoramaCamera cameraWithHeading:kInitialHeading
                                                              pitch:kInitialPitch zoom:kInitialZoom FOV:kDefaultFOV];
        panoramaConfigured_ = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
