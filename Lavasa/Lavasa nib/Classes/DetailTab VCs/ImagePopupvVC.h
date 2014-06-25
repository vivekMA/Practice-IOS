//
//  ImagePopupvVC.h
//  Lavasa
//
//  Created by Vivek Yadav on 6/20/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePopupvVC : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *Imgpop;
@property (strong, nonatomic) NSString *StrUrl;

- (IBAction)TapGestureAction:(UITapGestureRecognizer *)sender;
@end
