//
//  ReportIncidentTVC.m
//  ReportAIncident
//
//  Created by Vivek Sehrawat on 6/5/14.
//  Copyright (c) 2014 MA. All rights reserved.
//

#import "ReportIncidentTVC.h"
#import "DataBaseManager.h"

@interface ReportIncidentTVC ()

#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

@end

@implementation ReportIncidentTVC
@synthesize DescTxtView,CatTxtFld,LocationTxtFld;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.hidden=NO;
    SWRevealViewController *revealController = [self revealViewController];
    
    UIBarButtonItem *ButtonMenu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    ButtonMenu.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem = ButtonMenu;

    
    objList = nil;
    
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self.DefaultHideButton addTarget:self.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [DescTxtView.layer setBackgroundColor: [[UIColor whiteColor] CGColor]];
    [DescTxtView.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [DescTxtView.layer setBorderWidth: 1.0];
    //    [DescTxtView.layer setCornerRadius:8.0f];
    [DescTxtView.layer setMasksToBounds:YES];
    
    
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:flexButton, doneButton, nil];
    
    [toolbar setItems:itemsArray];
    
    [DescTxtView setInputAccessoryView:toolbar];
    
    // put the below code in view will appear
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
    
    geocoder = [[CLGeocoder alloc] init];
    
    
    
}

-(void)resignKeyboard {
    [DescTxtView resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    
    if (sender.tag==1) {
        // gallery
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    else{
        // turn on camera
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    [self.navigationController presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // user clicked the cancel on camera
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    PickedImage = info[UIImagePickerControllerEditedImage];
    
    self.IncidentImageView.image=PickedImage;
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(void)popoverListSelctedItem:(NSString *)categoryName
{
    self.CatTxtFld.text = categoryName;
    
    [popover dismissPopoverAnimated:YES];
}
#pragma mark - UITEXTVIEW & UITEXTFIELD DELEGATE METHODS

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.CatTxtFld) {
        
        if (objList == nil)
        {
            objList = [[PopoverListTVC alloc]initWithStyle:UITableViewStylePlain];
            objList.delegate = self;
            [objList setSizeForPopover];
        }
        
        if (IS_IPAD)
        {
            if ([objList respondsToSelector:@selector(preferredContentSize)])
            {
            }
            else
            {
                objList.contentSizeForViewInPopover = CGSizeMake(objList.contentSizeForViewInPopover.width, 0);
                
            }
            
            popover = [[UIPopoverController alloc]initWithContentViewController:objList];
            
            [popover presentPopoverFromRect:self.CatTxtFld.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        else
        {
            [objList setTitle:@"Select category"];
            
            //            objList =[self.storyboard instantiateViewControllerWithIdentifier:@"PopOverList"];
            //            [objList setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            //            [self presentViewController:objList animated:YES completion:nil];
            
            UINavigationController *navControllerList = [[UINavigationController alloc]initWithRootViewController:objList];
            
            [self presentViewController:navControllerList animated:YES completion:^{
                
            }];
        }
        return NO;
    }
    else
        return YES;
}

- (IBAction)Cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SubmitPressed:(id)sender {
    
    if ([DescTxtView.text length] < 1 ) { // check for the desc validation
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please add description" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        
        NSString *ImagePath=@"";
        
        if (self.IncidentImageView.image==nil)
        {
            NSLog(@"no underlying data");
        }else{
            ImagePath=[self saveImageToDisk];
        }
        
        DataBaseManager *DBM=[DataBaseManager database];
        
        BOOL success =[DBM reportIncidentWithCatName:CatTxtFld.text LocationName:LocationTxtFld.text Description:DescTxtView.text ImageUrl:ImagePath isSync:0];
        
        if (success) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Success" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
    }
}

-(NSString *)saveImageToDisk{
    
    NSString *stringPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES)objectAtIndex:0]stringByAppendingPathComponent:@"Images"];
    NSError *error = nil;
    if (![[NSFileManager defaultManager] fileExistsAtPath:stringPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:stringPath withIntermediateDirectories:NO attributes:nil error:&error];
    int timestamp = [[NSDate date] timeIntervalSince1970];
    NSString *ImagePath = [stringPath stringByAppendingFormat:@"/%d.png",timestamp];
    NSLog(@"%@",ImagePath);
    NSData *data = UIImagePNGRepresentation(PickedImage);
    [data writeToFile:ImagePath atomically:YES];
    
    return ImagePath;
    
}
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            
            NSString *completeAddress=@"";
            NSString *subThroughStr;
            NSString *postalCodeStr= [NSString stringWithFormat:@"%@",placemark.postalCode];
            NSString *localityStr= [NSString stringWithFormat:@"%@",placemark.locality];
            
            if (!(placemark.subThoroughfare == (id)[NSNull null] || placemark.subThoroughfare.length == 0)) {
                
                
                subThroughStr= [NSString stringWithFormat:@"%@",placemark.subThoroughfare];
            }
            if (!(placemark.thoroughfare == (id)[NSNull null] || placemark.thoroughfare.length == 0)) {
                
                
                completeAddress= [subThroughStr stringByAppendingString:placemark.thoroughfare];
            }
            
            if (!(placemark.postalCode == (id)[NSNull null] || placemark.postalCode.length == 0)) {
                
                
                completeAddress= [completeAddress stringByAppendingString:postalCodeStr];
            }
            
            if (!(placemark.locality == (id)[NSNull null] || placemark.locality.length == 0)) {
                
                
                completeAddress= [completeAddress stringByAppendingString:localityStr];
                NSLog(@"==========%@",localityStr);
                
                NSLog(@"%@",completeAddress);
            }
            
            self.LocationTxtFld.text = completeAddress;
            
            [locationManager stopUpdatingLocation];
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    self.IncidentImageView.image=nil;
    self.CatTxtFld.text=@"";
    LocationTxtFld.text=@"";
    DescTxtView.text=@"";
    
    [self.DefaultHideButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    
}
@end
