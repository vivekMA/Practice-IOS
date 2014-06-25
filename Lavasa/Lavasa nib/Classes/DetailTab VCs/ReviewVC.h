//
//  ReviewVC.h
//  Lavasa
//
//  Created by Vivek Yadav on 6/24/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewVC : UIViewController
{
    NSMutableArray *ArrayData;
}
- (IBAction)AddReviewAction:(id)sender;
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableviewReview;

@end
