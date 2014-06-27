//
//  lavasaAppDelegate.h
//  Lavasa nib
//
//  Created by Vivek Yadav on 6/9/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
@interface lavasaAppDelegate : UIResponder <UIApplicationDelegate,SWRevealViewControllerDelegate,GPPSignInDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
- (void)userLoggedIn;
- (void)userLoggedOut;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) UIWindow *WINDOW;
@end
