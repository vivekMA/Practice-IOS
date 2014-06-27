//
//  AppDelegate.m
//  Lavasa
//
//  Created by Vivek Sehrawat on 6/27/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "AppDelegate.h"
#import "AttractionTab1.h"
#import "MenuVC.h"
#import "LoginVC.h"
#import "DataBaseManager.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AttractionTabVC.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Constants.h"


@implementation AppDelegate

@synthesize navigationController,WINDOW;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //    static NSString * const kClientId = @"YOUR_CLIENT_ID";
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [GMSServices provideAPIKey:@"AIzaSyDBWIS3hfUJdUVGiHp3zoSZWz2C1__lgyM"];
    //  [[GPPSignIn sharedInstance] setClientID:KGoogleClientID];
    //  [[GPPSignIn sharedInstance] setDelegate:self];
    
    //   [[GPPSignIn sharedInstance] trySilentAuthentication];
    [DataBaseManager database];
    
    if ([[GPPSignIn sharedInstance] authentication]) {
        
        NSLog(@"Found a cached session");
        [self AddSlidingWindow];
        
    }else  if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        NSLog(@"Found a cached session");
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:@[@"public_profile"]
                                           allowLoginUI:NO
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          // also for intermediate states and NOT just when the session open
                                          [self sessionStateChanged:session state:state error:error];
                                      }];
        [self AddSlidingWindow];
        
        // If there's no cached session, we will show a login button
    }else
    {
        LoginVC *LoginViewController ;
        LoginViewController = [[LoginVC alloc] init];
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:LoginViewController];
    }
    [self.window makeKeyAndVisible];
    [self createCopyOfDatabaseIfNeeded];
    
    return YES;
}
-(void)AddSlidingWindow
{
    MenuVC * menuViewController = [[MenuVC alloc] init];
    UIStoryboard *mainStoryboard;
    
    if (IS_iPad) {
        mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
    }else mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
    AttractionTabVC *AttTabVC = (AttractionTabVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"AttractionTabVC"];
    
    SWRevealViewController *mainRevealController = [[SWRevealViewController alloc]
                                                    initWithRearViewController:[[UINavigationController alloc] initWithRootViewController:menuViewController] frontViewController:[[UINavigationController alloc] initWithRootViewController:AttTabVC]];
    mainRevealController.delegate = self;
    self.window.rootViewController = mainRevealController;
    
    
}
- (void)createCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"Lavasa.db"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
        return;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Lavasa.db"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}
#pragma mark- google + delegate method

- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth
                   error:(NSError *)error {
    if (error) {
        // If the error value is set, something has gone wrong. There are several
        // possible values, but all indicate the user is not signed-in, and the auth
        // should not be used.
        NSLog(@"Sign-In Error: %@", error);
        if ([error code] == -1) {
            NSLog(@"Unknown error, but user probably cancelled.");
        } else if([error code] == 400 &&
                  [[error domain] isEqualToString:@"com.google.HTTPStatus"]) {
            NSLog(@"400 error, user has probably disconnected using the "
                  "app managment page.");
        }
        // Ensure we have a clear setup for next sign in.
        [[GPPSignIn sharedInstance] signOut];
    } else {
        
        
        // We're signed in! We wont do much here, as the controllers can test
        // the sign-in state via the |sharedInstance| on |GPPSignIn|, but for more
        // complex applications writing an notification might be a good way of
        // signalling the state change.
    }
}
#pragma mark- facebook delegate method

// This method will handle ALL the session state changes in the app
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen){
        NSLog(@"Session opened");
        
        [self GetUserInfo];
        
        
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
    
    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES){
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [self showMessage:alertText withTitle:alertTitle];
        } else {
            
            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");
                
                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [self showMessage:alertText withTitle:alertTitle];
                
                // For simplicity, here we just show a generic message for all other errors
                // You can learn how to handle other errors using our guide: https://developers.facebook.com/docs/ios/errors
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];
                
                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
}

// Show the user the logged-out UI
- (void)userLoggedOut
{
    // Set the button title as "Log in with Facebook"
    //    UIButton *loginButton = [self.customLoginViewController loginButton];
    //    [loginButton setTitle:@"Log in with Facebook" forState:UIControlStateNormal];
    
    // Confirm logout message
    [self showMessage:@"You're now logged out" withTitle:@""];
}

// Show the user the logged-in UI
- (void)GetUserInfo
{
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
             
             
         }
     }
     ];
    
}

// Show an alert message
- (void)showMessage:(NSString *)text withTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:text
                               delegate:self
                      cancelButtonTitle:@"OK!"
                      otherButtonTitles:nil] show];
}

// During the Facebook login flow, your app passes control to the Facebook iOS app or Facebook in a mobile browser.
// After authentication, your app will be called back with the session information.
// Override application:openURL:sourceApplication:annotation to call the FBsession object that handles the incoming URL
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    // return [FBSession.activeSession handleOpenURL:url];
    
    
    return [GPPURLHandler handleURL:url
                  sourceApplication:sourceApplication
                         annotation:annotation];
    
}

#pragma mark- sliding window method
- (NSString*)stringFromFrontViewPosition:(FrontViewPosition)position
{
    NSString *str = nil;
    if ( position == FrontViewPositionLeft ) str = @"FrontViewPositionLeft";
    if ( position == FrontViewPositionRight ) str = @"FrontViewPositionRight";
    if ( position == FrontViewPositionRightMost ) str = @"FrontViewPositionRightMost";
    if ( position == FrontViewPositionRightMostRemoved ) str = @"FrontViewPositionRightMostRemoved";
    return str;
}
- (void)revealController:(SWRevealViewController *)revealController willMoveToPosition:(FrontViewPosition)position
{
    //NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}
- (void)revealController:(SWRevealViewController *)revealController didMoveToPosition:(FrontViewPosition)position
{
    //NSLog( @"%@: %@", NSStringFromSelector(_cmd), [self stringFromFrontViewPosition:position]);
}
- (void)revealController:(SWRevealViewController *)revealController willRevealRearViewController:(UIViewController *)rearViewController
{
    //NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(SWRevealViewController *)revealController didRevealRearViewController:(UIViewController *)rearViewController
{
    // NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(SWRevealViewController *)revealController willHideRearViewController:(UIViewController *)rearViewController
{
    // NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(SWRevealViewController *)revealController didHideRearViewController:(UIViewController *)rearViewController
{
    //NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(SWRevealViewController *)revealController willShowFrontViewController:(UIViewController *)rearViewController
{
    //NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(SWRevealViewController *)revealController didShowFrontViewController:(UIViewController *)rearViewController
{
    // NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(SWRevealViewController *)revealController willHideFrontViewController:(UIViewController *)rearViewController
{
    // NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)revealController:(SWRevealViewController *)revealController didHideFrontViewController:(UIViewController *)rearViewController
{
    //NSLog( @"%@", NSStringFromSelector(_cmd));
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
