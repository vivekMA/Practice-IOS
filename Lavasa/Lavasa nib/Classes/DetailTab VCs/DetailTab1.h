//
//  DetailTab1.h
//  Lavasa
//
//  Created by Vivek Yadav on 6/19/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLStarRatingControl.h"
@interface DetailTab1 : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *ImgPlace;
@property (weak, nonatomic) IBOutlet UILabel *LblName;
@property (weak, nonatomic) IBOutlet UILabel *LblAddress;
@property (weak, nonatomic) IBOutlet UITextView *TextviewDetail;
@property (weak, nonatomic) IBOutlet DLStarRatingControl *ImgRating;
- (IBAction)backAction:(id)sender;

@end
