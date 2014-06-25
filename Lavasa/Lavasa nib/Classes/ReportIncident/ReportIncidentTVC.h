//
//  ReportIncidentTVC.h
//  ReportAIncident
//
//  Created by Vivek Sehrawat on 6/5/14.
//  Copyright (c) 2014 MA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PopoverListTVC.h"

#import <CoreLocation/CoreLocation.h>


@interface ReportIncidentTVC : UITableViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate,PopoverListDelegate,CLLocationManagerDelegate>

{
    PopoverListTVC *objList;
    UIPopoverController *popover;
    
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    UIImage *PickedImage;
    
}
- (IBAction)Cancel:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *DefaultHideButton;

- (IBAction)SubmitPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong, nonatomic) IBOutlet UITextField *CatTxtFld;
@property (strong, nonatomic) IBOutlet UITextField *LocationTxtFld;

@property (strong, nonatomic) IBOutlet UITextView *DescTxtView;
@property (strong, nonatomic) IBOutlet UIImageView *IncidentImageView;



- (IBAction)selectPhoto:(UIButton *)sender;

@end
