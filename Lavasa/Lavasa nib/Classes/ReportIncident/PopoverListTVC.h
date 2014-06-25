//
//  PopoverListTVC.h
//  ReportAIncident
//
//  Created by Vivek Sehrawat on 6/11/14.
//  Copyright (c) 2014 MA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopoverListDelegate <NSObject>

@required

-(void)popoverListSelctedItem:(NSString *)categoryName;

@end

@interface PopoverListTVC : UITableViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) NSArray *arrList;
@property(strong, nonatomic) id<PopoverListDelegate> delegate;

-(void)setSizeForPopover;
- (IBAction)cancelPressed:(id)sender;

@end

