//
//  BookingTVCell.h
//  Lavasa
//
//  Created by Vivek Yadav on 7/1/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingTVCell : UITableViewCell
{
    
 
}
@property (weak, nonatomic) IBOutlet UITextField *CellTextGender;
@property (weak, nonatomic) IBOutlet UITextField *CellTextAge;
@property (weak, nonatomic) IBOutlet UITextField *CellTextLastName;
@property (weak, nonatomic) IBOutlet UITextField *CellTextFirstName;
@property (weak, nonatomic) IBOutlet UILabel *lblSerialNo;
@end
