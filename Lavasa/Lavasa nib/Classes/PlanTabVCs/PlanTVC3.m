//
//  PlanTVC3.m
//  Lavasa
//
//  Created by Vivek Yadav on 6/26/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "PlanTVC3.h"

@interface PlanTVC3 ()

@end

@implementation PlanTVC3

- (id)initWithStyle:(UITableViewStyle)style
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
  
     self.title=@"Plan 3";
    self.navigationController.navigationBar.hidden=NO;
    SWRevealViewController *revealController = [self revealViewController];
    
    UIBarButtonItem *ButtonMenu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    ButtonMenu.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem = ButtonMenu;

 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PlanCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    
    //    PlanTVCell *PlanCell = (PlanTVCell *) cell;
    //    PlanCell.LblName.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"name"];
    //
    //     PlanCell.LblPrice.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"name"];
    //
    //     PlanCell.LblDescription.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"name"];
    //
    //    PlanCell.LblDuration.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"address"];
    //    [PlanCell.ImgViewCat setImageWithURL:[NSURL URLWithString:[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    //    PlanCell.btnBook.tag=indexPath.row;
    //
    //
    //    //  DLStarRatingControl *customNumberOfStars = (DLStarRatingControl *)[cell viewWithTag:1001];
    //    PlanCell.ImgStar.rating = [[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"overall_rating"] floatValue];
    
}
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tapped button at row: %@",self.navigationController.viewControllers);
}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
}@end
