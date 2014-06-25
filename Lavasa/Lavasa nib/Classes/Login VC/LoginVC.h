//
//  LoginVC.h
//  Lavasa nib
//
//  Created by Vivek Yadav on 6/10/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SharedData.h"
#import "MBProgressHUD.h"

@interface LoginVC : UIViewController<SWRevealViewControllerDelegate,GPPSignInDelegate>
{
    __weak IBOutlet GPPSignInButton *GoogleSignBtn;
    MBProgressHUD *objhud;
    GPPSignIn *signIn;
}
- (IBAction)fbLogin:(id)sender;
- (IBAction)googlePlus:(id)sender;

@end
