//
//  AttractionTVCell.h
//  Lavasa
//
//  Created by Vivek Yadav on 6/17/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLStarRatingControl.h"
@interface AttractionTVCell : UITableViewCell
- (IBAction)BookBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *ImgViewCat;
@property (weak, nonatomic) IBOutlet UILabel *lblCat;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnBook;
@property (weak, nonatomic) IBOutlet DLStarRatingControl *ImgStar;

@end
