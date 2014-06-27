//
//  LoginVC.m
//  Lavasa nib
//
//  Created by Vivek Yadav on 6/10/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "LoginVC.h"
#import "AttractionTab1.h"
#import "MenuVC.h"
#import "Constants.h"
#import <GoogleOpenSource/GoogleOpenSource.h>

#import "AttractionTabVC.h"
#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
@interface LoginVC ()

@end

@implementation LoginVC

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
    
     if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
         
         NSLog(@"hiiii");
         
     }
    // If the session state is any of the two "open" states when the button is clicked
  
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)googlePlus:(id)sender {
    
    objhud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    objhud.labelText=@"Authenticating...";
    objhud.color=[UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0];

    
    
    
    signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = KGoogleClientID;
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    signIn.scopes = [NSArray arrayWithObjects:
                     @"https://www.googleapis.com/auth/plus.login",
                    nil];


    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    [signIn authenticate];
    
   

}
-(void)refreshInterfaceBasedOnSignIn {
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.

        // Perform other actions here, such as showing a sign-out button
    } else {
//        self.signInButton.hidden = NO;
        // Perform other actions here
    }
}
- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    objhud.hidden=YES;
    if(error)
        NSLog(@"%@",error);
        
        //[  signIn authenticate];
    else
        
    {
    
    MenuVC *menuViewController = [[MenuVC alloc] init];
    
    UIStoryboard *mainStoryboard;
    if (IS_iPad) {
        mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
    }else mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    
  
    AttractionTabVC *AttTabVC = (AttractionTabVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"AttractionTabVC"];
    
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]
                                                    initWithRearViewController:[[UINavigationController alloc] initWithRootViewController:menuViewController] frontViewController:[[UINavigationController alloc] initWithRootViewController:AttTabVC]];
    mainRevealController.delegate = self;
    [self.navigationController pushViewController:mainRevealController animated:YES];
    self.navigationController.navigationBar.hidden=YES;
    

    NSLog(@"Received Error %@  and auth object==%@",error,auth);
    }
    if (error) {
        // Do some error handling here.
    } else {
      //  [self refreshInterfaceBasedOnSignIn];
        
        NSLog(@"email %@ ",[NSString stringWithFormat:@"Email: %@",signIn.userEmail]);
         NSLog(@"email %@ ",[NSString stringWithFormat:@"Email: %@",signIn.init]);
        NSLog(@"Received error %@ and auth object %@",error, auth);
        
        NSLog(@"email %@ ",[NSString stringWithFormat:@"Email: %@",[GPPSignIn sharedInstance].userEmail]);
        NSLog(@"Received error %@ and auth object %@",error, auth);
        
        // 1. Create a |GTLServicePlus| instance to send a request to Google+.
        GTLServicePlus* plusService = [[GTLServicePlus alloc] init] ;
        plusService.retryEnabled = YES;
        
        // 2. Set a valid |GTMOAuth2Authentication| object as the authorizer.
        [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
        
        
        GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
        
        // *4. Use the "v1" version of the Google+ API.*
        plusService.apiVersion = @"v1";
        
        [plusService executeQuery:query
                completionHandler:^(GTLServiceTicket *ticket,
                                    GTLPlusPerson *person,
                                    NSError *error) {
                    if (error) {

                        //Handle Error
                        
                    } else
                    {
                        NSLog(@"Email= %@",[GPPSignIn sharedInstance].authentication.userEmail);
                        NSLog(@"GoogleID=%@",person.identifier);
                        NSLog(@"User Name=%@",[person.name.givenName stringByAppendingFormat:@" %@",person.name.familyName]);
                        NSLog(@"Gender=%@",person.gender);
                        
                    }
                }];
    }
}

- (IBAction)fbLogin:(id)sender {
    
    objhud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    objhud.labelText=@"Authenticating...";
    objhud.color=[UIColor colorWithRed:0.23 green:0.50 blue:0.82 alpha:0];

    if (FBSession.activeSession.state == FBSessionStateOpen
        || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
        
        // Close the session and remove the access token from the cache
        // The session state handler (in the app delegate) will be called automatically
        [FBSession.activeSession closeAndClearTokenInformation];
        
        // If the session state is not any of the two "open" states when the button is clicked
    } else {
        // Open a session showing the user the login UI
        // You must ALWAYS ask for public_profile permissions when opening a session
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:YES
                                      completionHandler:
         ^(FBSession *session, FBSessionState state, NSError *error) {
             
             // Retrieve the app delegate
              [self sessionStateChanged:session state:state error:error];
         }];
    }
}
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    objhud.hidden=YES;
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        [FBRequestConnection
         startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                           id<FBGraphUser> user,
                                           NSError *error) {
             if (!error) {
                 NSString *fbUserEmail= @"";
                 
                 NSLog(@"%@",user);
                 
                 fbUserEmail=[user objectForKey:@"email"];
                 NSLog(@"%@",fbUserEmail);
                 
                 [SharedData sharedObj].Name=[user objectForKey:@"name"];
                 [SharedData sharedObj].Email=[user objectForKey:@"email"];
                 [SharedData sharedObj].DOB=[user objectForKey:@"birthday"];
                 [SharedData sharedObj].UserId=[user objectForKey:@"id"];
                 [SharedData sharedObj].Gender=[user objectForKey:@"gender"];

                MenuVC *menuViewController = [[MenuVC alloc] init];
                 
                 UIStoryboard *mainStoryboard;
                 if (IS_iPad) {
                     mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
                 }else mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
                 AttractionTabVC *AttTabVC = (AttractionTabVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"AttractionTabVC"];
                
                 SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]
                                                                 initWithRearViewController:[[UINavigationController alloc] initWithRootViewController:menuViewController] frontViewController:[[UINavigationController alloc] initWithRootViewController:AttTabVC]];
                 mainRevealController.delegate = self;
                 [self.navigationController pushViewController:mainRevealController animated:YES];
                 self.navigationController.navigationBar.hidden=YES;
             }
         }
         ];

    }
}
@end
