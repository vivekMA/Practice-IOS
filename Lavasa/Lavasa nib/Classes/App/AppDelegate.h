//
//  AppDelegate.h
//  Lavasa
//
//  Created by Vivek Sehrawat on 6/27/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate  : UIResponder <UIApplicationDelegate,SWRevealViewControllerDelegate,GPPSignInDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
- (void)userLoggedIn;
- (void)userLoggedOut;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) UIWindow *WINDOW;

@end
