//
//  MenuVC.h
//  Lavasa nib
//
//  Created by Vivek Yadav on 6/9/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttractionTab1.h"
@interface MenuVC : UIViewController
{
        __weak IBOutlet UITableView *firstTableView;
    NSMutableArray *ArraySectionTitle,*ArrayBool;
    NSMutableDictionary *DictSectionItems;
}

@end
