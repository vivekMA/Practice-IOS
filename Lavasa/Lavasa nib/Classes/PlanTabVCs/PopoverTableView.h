//
//  PopoverTableView.h
//  Lavasa
//
//  Created by Vivek Yadav on 7/1/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopoverTableViewDelagate <NSObject>

@required

-(void)popoverListSelctedItem:(NSString *)categoryName :(NSString *)CatType;
;

@end

@interface PopoverTableView : UITableViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSString *PopUpCatType;
}
@property (strong,nonatomic) NSMutableArray *arrList;
@property(strong, nonatomic) id<PopoverTableViewDelagate> delegate;

-(void)setSizeForPopover :(NSArray *)categoryArr :(NSString *)CatType ;
- (IBAction)cancelPressed:(id)sender;

@end

