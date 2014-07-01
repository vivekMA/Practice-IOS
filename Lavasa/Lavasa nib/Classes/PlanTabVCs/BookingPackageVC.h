//
//  BookingPackageVC.h
//  Lavasa
//
//  Created by Vivek Yadav on 6/30/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverTableView.h"
@interface BookingPackageVC : UITableViewController<UIPopoverControllerDelegate,PopoverTableViewDelagate>
{
    
     PopoverTableView *objList;
      UIPopoverController *popover;
}
- (IBAction)AddBtnAction:(id)sender;

@end
