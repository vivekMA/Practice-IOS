
//  AddReviewVC.m
//  Lavasa
//  Created by Vivek Yadav on 6/24/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.


#import <GoogleOpenSource/GoogleOpenSource.h>
#import "AddReviewVC.h"
#import "FMDatabase.h"
@interface AddReviewVC ()
@end
@implementation AddReviewVC
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
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)CancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)DoneAction:(id)sender {
    
    if (self.TextfieldTitle.text.length>0 || self.TextViewDescrip.text.length >0) {
        
     

        if ([[GPPSignIn sharedInstance] authentication]) {
            [self insertData];                     // Perform other actions here, such as showing a sign-out button
        } else {
            
            objhud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            objhud.labelText=@"Authenticating...";
            objhud.color=[UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0];
            
            
          GPPSignIn *signIn1 = [GPPSignIn sharedInstance];
            signIn1.shouldFetchGooglePlusUser = YES;
            signIn1.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
            
            signIn1.clientID = KGoogleClientID;
            
            // Uncomment one of these two statements for the scope you chose in the previous step
            signIn1.scopes =  [NSArray arrayWithObjects: @"https://www.googleapis.com/auth/plus.login", nil ];
            
            
            // Optional: declare signIn.actions, see "app activities"
            signIn1.delegate = self;
            [signIn1 authenticate];
        }
    }else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"All fields are mandatory" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        alert=nil;
    }
}
- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    if (error) {
        
        NSLog(@"email %@ ",[NSString stringWithFormat:@"Email: %@",signIn.userEmail]);

    } else {
          [self insertData];
      }
}
-(void)insertData
{
    FMDatabase *database = [FMDatabase databaseWithPath:[self databasePath]];
    [database open];
    
    NSString *rating=[NSString stringWithFormat:@"%f",self.Rating.rating];
    NSString *description=self.TextViewDescrip.text;
    NSString *title=self.TextfieldTitle.text;
    NSString *url=@"http://icons.iconarchive.com/icons/benjigarner/softdimension/256/Image-ready-CS-2-icon.png";
    
    NSString *query=[NSString stringWithFormat:@"INSERT INTO review (id,rating,review,user_profile_name,gplus_url,user_id,place_id) VALUES ('%d','%@','%@','%@','%@','%d','%d')",34,rating,description,title,url,88,1];
    NSLog(@"%@",query);
    
    BOOL success= [database executeUpdate:query];
    
    NSLog(success ? @"Inserted" : @"Failed");
    [database close];
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(NSString *)databasePath{
    
    NSString *documents=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *databasePath=[documents stringByAppendingPathComponent:@"lavasa_web_service.sqlite"];
    NSFileManager *fileManger=[NSFileManager defaultManager];
    if (![fileManger fileExistsAtPath:databasePath]) {
        NSString *bundlePath=[[NSBundle mainBundle]pathForResource:@"lavasa_web_service" ofType:@"sqlite"];
        [fileManger copyItemAtPath:bundlePath toPath:databasePath error:nil];
    }
    return  databasePath;
    }
@end
