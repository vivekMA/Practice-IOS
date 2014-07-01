//
//  PopoverListTVC.m
//  ReportAIncident
//
//  Created by Vivek Sehrawat on 6/11/14.
//  Copyright (c) 2014 MA. All rights reserved.
//

#import "PopoverTableView.h"

@interface PopoverTableView ()

#define IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)


@end

@implementation PopoverTableView
@synthesize arrList;

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    // road issues, apartment issues, villa issues.
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewWillAppear:(BOOL)animated {
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    //    [self setSizeForPopover];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setSizeForPopover :(NSArray *)categoryArr :(NSString *)CatType
{
    PopUpCatType=CatType;
     arrList = [NSMutableArray arrayWithArray:categoryArr];
    
    //Calculate how tall the view should be by multiplying
    //the individual row height by the total number of rows.
    NSInteger rowsCount = [self.arrList count];
    NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
                                           heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSInteger totalRowsHeight = rowsCount * singleRowHeight;
    
    //Calculate how wide the view should be by finding how
    //wide each string is expected to be
    CGFloat largestLabelWidth = 0;
    for (NSString *colorName in self.arrList)
    {
        //Checks size of text using the default font for UITableViewCell's textLabel.
        CGSize labelSize = [colorName sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
        if (labelSize.width > largestLabelWidth) {
            largestLabelWidth = labelSize.width;
        }
    }
    
    //Add a little padding to the width
    //    CGFloat popoverWidth = largestLabelWidth + 100;
    
    //Set the property to tell the popover container how big this view will be.
    
    if ([self respondsToSelector:@selector(preferredContentSize)])
    {
        self.preferredContentSize = CGSizeMake(self.preferredContentSize.width, totalRowsHeight);
    }
    else
    {
        self.contentSizeForViewInPopover = CGSizeMake(self.contentSizeForViewInPopover.width, totalRowsHeight);
    }
    
    
}

- (IBAction)cancelPressed:(id)sender {
    
    if (IS_IPHONE)
    {
        [self dismissList];
    }
}

-(void)dismissList
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.arrList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    cell.textLabel.text = [arrList objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        [self.delegate popoverListSelctedItem:[self.arrList objectAtIndex:indexPath.row]:PopUpCatType];
    
    if (IS_IPHONE)
    {
        [self dismissList];
    }
}


@end
