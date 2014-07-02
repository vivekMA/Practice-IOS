//
//  PlanDetailTVCell.h
//  Lavasa
//
//  Created by Vivek Yadav on 6/27/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLStarRatingControl.h"
@interface PlanDetailTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImgIternary;

@property (weak, nonatomic) IBOutlet UILabel *LblIternaryAddress;
@property (weak, nonatomic) IBOutlet DLStarRatingControl *RatingView;
@property (weak, nonatomic) IBOutlet UILabel *LblIterninaryName;
@property (weak, nonatomic) IBOutlet UIButton *paranomaBtnAction;

@end
