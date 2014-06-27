//
//  AttractionTab2.h
//  Lavasa
//
//  Created by Vivek Yadav on 6/17/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLStarRatingControl.h"
#import "ARKit.h"
#import "MBProgressHUD.h"
#import <CoreMotion/CoreMotion.h>
#import "SharedData.h"
#import "MapViewController.h"


@interface AttractionTab1 : UITableViewController<ARLocationDelegate,CLLocationManagerDelegate,NSXMLParserDelegate>
{
    __weak IBOutlet UITableView *TableViewCat;
    NSArray *ArrayCat;
    NSMutableArray *ArrayData;
    int NumCellCount,Datacount;
    ARViewController    *_arViewController;

    // below are the objects for AR
    CLLocationManager *locationManager;
    CLLocation *location;
    
    NSURLConnection *connetion1;
    NSString *currentData;
    NSMutableData *webData;
    MBProgressHUD *objhud;
    
    NSMutableArray *Places;
    
    NSMutableArray *namearray;

    NSMutableArray *ratingArrary;
    NSMutableArray *Longarray;
    NSMutableArray *Latarray;
    
    CLLocationCoordinate2D coordinateLocal;

    NSArray *LocationsUpdated;
    


}
- (IBAction)MapButtonClicked:(id)sender;

@property (strong, nonatomic) CMMotionManager *motionManager;

@end
