//
//  DetailTab1.m
//  Lavasa
//
//  Created by Vivek Yadav on 6/19/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "DetailTab1.h"
#import "AttractionTabVC.h"
#import "AttractionTab1.h"
@interface DetailTab1 ()

@end

@implementation DetailTab1

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
    
//    UINavigationController *navController = [(AttractionTab1*)[[UIApplication sharedApplication] delegate] navigationController];
//    
//    navController.navigationBar.tintColor=[UIColor redColor];
//    
//    AttractionTab1 *appDelegate = (AttractionTab1 *)[[UIApplication sharedApplication] delegate];
//
//    NSArray *viewContrlls=[[appDelegate navigationController] viewControllers];
//    NSLog(@"%@",viewContrlls);
//    
    
//      NSArray *controllerNameArray = [self.tabBarController.navigationController viewControllers];
//     NSLog(@"%@",controllerNameArray);
    
    
 //   [[[self.tabBarController.navigationController viewControllers] objectAtIndex:0] navigationController].navigationBar.backgroundColor=[UIColor redColor];
    
    NSLog(@"%@",[SharedData sharedObj].DictDetail);
    [self.ImgPlace setImageWithURL:[NSURL URLWithString:[[SharedData sharedObj].DictDetail objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    self.LblName.text=[[SharedData sharedObj].DictDetail objectForKey:@"name"];
    self.LblAddress.text=[[SharedData sharedObj].DictDetail objectForKey:@"address"];
    self.TextviewDetail.text=[[SharedData sharedObj].DictDetail objectForKey:@"address"];
    self.ImgRating.rating=[[[SharedData sharedObj].DictDetail objectForKey:@"overall_rating"] floatValue];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}
//
///*
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}

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

- (IBAction)backAction:(id)sender {
    
  //  NSArray *controllerNameArray = [self.tabBarController.navigationController viewControllers];
    
    
  //  NSLog(@"%@",controllerNameArray);
    
   // [self.navigationController popViewControllerAnimated:[controllerNameArray objectAtIndex:0] ];
    
    [(UINavigationController *)self.tabBarController.selectedViewController popToRootViewControllerAnimated:NO];
    
       // [self.navigationController popToViewController:[controllerNameArray objectAtIndex:0] animated:YES];
}
@end
