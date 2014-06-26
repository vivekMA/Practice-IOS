//
//  PlanTVCell.h
//  Lavasa
//
//  Created by Vivek Yadav on 6/26/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanTVCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImgPlan;
@property (weak, nonatomic) IBOutlet UILabel *LblName;
@property (weak, nonatomic) IBOutlet UILabel *LblPrice;
@property (weak, nonatomic) IBOutlet UILabel *LblDescription;
@property (weak, nonatomic) IBOutlet UIButton *BtnBook;
@property (weak, nonatomic) IBOutlet UILabel *LblDuration;

@end
