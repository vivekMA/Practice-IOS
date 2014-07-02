//
//  PlanDetailTVC.h
//  Lavasa
//
//  Created by Vivek Yadav on 6/27/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanDetailTVC : UITableViewController
{
    NSMutableArray *ArrayData;
}

@property (weak, nonatomic) IBOutlet UILabel *LblPackage;
@property (weak, nonatomic) IBOutlet UILabel *LblAddress;
@property (weak, nonatomic) IBOutlet UIImageView *ImgPackage;
@property (weak, nonatomic) IBOutlet UILabel *LblPrice;
@property (weak, nonatomic) IBOutlet UIButton *BtnBook;
@property (copy, nonatomic) NSDictionary *DictPackage;
@end
