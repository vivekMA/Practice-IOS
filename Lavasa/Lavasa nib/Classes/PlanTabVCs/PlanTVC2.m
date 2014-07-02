//
//  PlanTVC2.m
//  Lavasa
//
//  Created by Vivek Yadav on 6/26/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "PlanTVC2.h"
#import "PlanTVCell.h"
#import "AppDataBase.h"
#import "FMDatabase.h"
#import "PlanDetailTVC.h"
@interface PlanTVC2 ()

@end

@implementation PlanTVC2

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.title=@"Plan 2";
    self.navigationController.navigationBar.hidden=NO;
    SWRevealViewController *revealController = [self revealViewController];
    
    UIBarButtonItem *ButtonMenu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    
    ButtonMenu.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem = ButtonMenu;

    
    
    ArrayData=[[NSMutableArray alloc]init];
    AppDataBase *DBM=[AppDataBase database];
    
    FMResultSet *Result =[DBM PlanCatDetail:@"2" ];
    while([Result next]) {
        
        NSLog(@"%@",[Result stringForColumn:@"name"]);
        [ArrayData addObject:[[NSDictionary alloc]initWithObjectsAndKeys:[Result stringForColumn:@"id"],@"id",[Result stringForColumn:@"name"],@"name",[Result stringForColumn:@"duration"],@"duration",nil]];
        NSLog(@"%@",ArrayData);
    }

 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return ArrayData.count;
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
    
    
    PlanTVCell *PlanCell = (PlanTVCell *) cell;
    PlanCell.LblName.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    //   PlanCell.LblPrice.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    //   PlanCell.LblDescription.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"duration"];
    
    PlanCell.LblDuration.text=[NSString stringWithFormat:@"Dutration: %@",[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"duration"]];
    //    [PlanCell.ImgViewCat setImageWithURL:[NSURL URLWithString:[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    PlanCell.BtnBook.tag=indexPath.row;
    
    
    //  DLStarRatingControl *customNumberOfStars = (DLStarRatingControl *)[cell viewWithTag:1001];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"GoToPlanDetail"])
    {
        PlanDetailTVC *pdvc= segue.destinationViewController;
        NSLog(@"%@", [[ArrayData objectAtIndex:[sender tag]]objectForKey:@"id"]);
        
        pdvc.DictPackage=[ArrayData objectAtIndex:[sender tag]];
        //        NSLog(@"%@",[ArrayData objectAtIndex:[sender tag]]);
        
    }
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
    
}

@end
