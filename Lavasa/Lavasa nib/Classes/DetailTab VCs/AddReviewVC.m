
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

        
        // Do some error handling here.
    } else {
        //  [self refreshInterfaceBasedOnSignIn];
        
        
          [self insertData];
        
        
        
//        NSLog(@"email %@ ",[NSString stringWithFormat:@"Email: %@",signIn.userEmail]);
//        NSLog(@"email %@ ",[NSString stringWithFormat:@"Email: %@",signIn.init]);
// 
//        
//        // 1. Create a |GTLServicePlus| instance to send a request to Google+.
//        GTLServicePlus* plusService = [[GTLServicePlus alloc] init] ;
//        plusService.retryEnabled = YES;
//        
//        // 2. Set a valid |GTMOAuth2Authentication| object as the authorizer.
//        [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
//        
//        
//        GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
//        
//        // *4. Use the "v1" version of the Google+ API.*
//        plusService.apiVersion = @"v1";
//        
//        [plusService executeQuery:query
//                completionHandler:^(GTLServiceTicket *ticket,
//                                    GTLPlusPerson *person,
//                                    NSError *error) {
//                    if (error) {
//                        
//                        //Handle Error
//                        
//                    } else
//                    {
//                        NSLog(@"Email= %@",[GPPSignIn sharedInstance].authentication.userEmail);
//                        NSLog(@"GoogleID=%@",person.identifier);
//                        NSLog(@"User Name=%@",[person.name.givenName stringByAppendingFormat:@" %@",person.name.familyName]);
//                        NSLog(@"Gender=%@",person.gender);
//                        
//                    }
//                }];
    }
}
-(void)insertData
{
    FMDatabase *database = [FMDatabase databaseWithPath:[self databasePath]];
    [database open];
    
    NSString *rating=[NSString stringWithFormat:@"%f",self.Rating.rating];
    NSString *description=self.TextViewDescrip.text;
    NSString *title=self.TextfieldTitle.text;
    
    NSString *query=[NSString stringWithFormat:@"INSERT INTO review_demo (rating,description,title,icon) VALUES ('%@','%@','%@','%@')",rating,description,title,@"http://icons.iconarchive.com/icons/benjigarner/softdimension/256/Image-ready-CS-2-icon.png"];
    
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
