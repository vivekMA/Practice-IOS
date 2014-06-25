//
//  ReviewTableCell.h
//  Lavasa
//
//  Created by Vivek Yadav on 6/24/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLStarRatingControl.h"
@interface ReviewTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImgRating;
@property (weak, nonatomic) IBOutlet UILabel *LblUserName;
@property (weak, nonatomic) IBOutlet UILabel *LblReview;
@property (weak, nonatomic) IBOutlet DLStarRatingControl *ImgStar;
@property (weak, nonatomic) IBOutlet UIImageView *ImgProfile;
@property (weak, nonatomic) IBOutlet UIButton *BtnLike;
@property (weak, nonatomic) IBOutlet UILabel *LblLike;
@end
