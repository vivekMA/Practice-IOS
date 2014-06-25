//
//  AddReviewVC.h
//  Lavasa
//
//  Created by Vivek Yadav on 6/24/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLStarRatingControl.h"
#import "MBProgressHUD.h"
@interface AddReviewVC : UIViewController<GPPSignInDelegate>
{
     MBProgressHUD *objhud;
    GPPSignIn  *signIn;
}
- (IBAction)CancelAction:(id)sender;
- (IBAction)DoneAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *TextViewDescrip;
@property (weak, nonatomic) IBOutlet UITextField *TextfieldTitle;
@property (weak, nonatomic) IBOutlet DLStarRatingControl *Rating;

@end
