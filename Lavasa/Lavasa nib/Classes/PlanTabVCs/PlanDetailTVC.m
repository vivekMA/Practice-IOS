//
//  PlanDetailTVC.m
//  Lavasa
//
//  Created by Vivek Yadav on 6/27/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "PlanDetailTVC.h"
#import "PlanDetailTVCell.h"
#import "AppDataBase.h"
@interface PlanDetailTVC ()

@end

@implementation PlanDetailTVC
@synthesize DictPackage;

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
  
    NSLog(@"%@",DictPackage);
    
    self.ImgPackage.image=[UIImage imageNamed:@"120x120.png"];
    self.LblPrice.text=@"1.99$";
    self.LblAddress.text=@"";
    self.LblPackage.text=[DictPackage objectForKey:@"name"];
    
    ArrayData=[[NSMutableArray alloc]init];
    AppDataBase *DBM=[AppDataBase database];
    
    FMResultSet *Result =[DBM PlanDetailwithPackageID:[DictPackage objectForKey:@"id"]];
    while([Result next]) {
        NSLog(@"%@",[Result stringForColumn:@"icon"]);
        NSLog(@"%@",[Result stringForColumn:@"overall_rating"]);
        
        NSDictionary *DicData=[[NSDictionary alloc]initWithObjectsAndKeys: [Result stringForColumn:@"icon"],@"icon",
                               [Result stringForColumn:@"place_name"],@"place_name",
                               [Result stringForColumn:@"id"],@"id",
                               [Result stringForColumn:@"place_reference_id"],@"place_reference_id",
                               [Result stringForColumn:@"lng"],@"lng",
                               [Result stringForColumn:@"formatted_address"],@"formatted_address",
                               [Result stringForColumn:@"formatted_phone_number"],@"formatted_phone_number",
                               [Result stringForColumn:@"open_now"],@"open_now",
                               [Result stringForColumn:@"user_location"],@"user_location",
                               [Result stringForColumn:@"lat"],@"lat",
                               [Result stringForColumn:@"overall_rating"],@"overall_rating",nil];
      [ArrayData addObject:DicData];
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
    static NSString *CellIdentifier = @"PlanDetailTVCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
  
    PlanDetailTVCell  *PlanCell = (PlanDetailTVCell *) cell;
 
    PlanCell.self.LblIternaryAddress.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"formatted_address"];
    PlanCell.self.LblIterninaryName.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"place_name"];
    PlanCell.self.RatingView.rating=4;
    [PlanCell.self.ImgIternary setImageWithURL:[NSURL URLWithString:[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
//    [PlanCell.self.ImgProfile setImageWithURL:[NSURL URLWithString:[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
//    PlanCell.ImgStar.tag=indexPath.row;
//    PlanCell.ImgStar.rating=[[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"rating"] floatValue];
//    PlanCell.LblLike.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"user_like"];
//    
//    [PlanCell.BtnLike addTarget:self action:@selector(LikebtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    PlanCell.BtnLike.tag=indexPath.row;
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
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
