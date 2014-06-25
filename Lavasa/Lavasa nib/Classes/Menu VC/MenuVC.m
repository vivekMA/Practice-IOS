//
//  MenuVC.m
//  Lavasa nib
//
//  Created by Vivek Yadav on 6/9/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "MenuVC.h"
#import "ReportIncidentTVC.h"
#import "lavasaAppDelegate.h"
#import "loginVC.h"
#import "AttractionTabVC.h"
#import "PlanTVC.h"
@interface MenuVC ()
@end
@implementation MenuVC
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationController.navigationBar.hidden=YES;
    ArraySectionTitle = [NSMutableArray arrayWithObjects:@"PLAN", @"EXPLORE",@"REPORT INCIDENT", @"SETTINGS", @"HELP",@"LOGOUT", nil];
    ArrayBool    = [NSMutableArray arrayWithObjects:[NSNumber numberWithBool:YES],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO],
                           [NSNumber numberWithBool:NO] ,[NSNumber numberWithBool:NO], nil];
    
   
        DictSectionItems  = [[NSMutableDictionary alloc] init];
        [DictSectionItems setValue:[NSArray arrayWithObjects:@"ATTRACTION", @"EVENTS", @"NEAR PLACES",@"TRANSPORT", nil] forKey:[ArraySectionTitle objectAtIndex:1]];

}
#pragma marl - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
return [ArraySectionTitle count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[ArrayBool objectAtIndex:section] boolValue]) {
        return [[DictSectionItems valueForKey:[ArraySectionTitle objectAtIndex:section]] count];
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *ViewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    ViewHeader.backgroundColor = [UIColor whiteColor];
    ViewHeader.tag = section;
    
    UIImageView *ImgIcon=[[UIImageView alloc]initWithFrame:CGRectMake(10,8,35,35)];
    ImgIcon.image=[UIImage imageNamed:[ArraySectionTitle objectAtIndex:section]];
    [ViewHeader addSubview:ImgIcon];
    
    UILabel *LblTitle=[[UILabel alloc]initWithFrame:CGRectMake(60, 0, self.view.frame.size.width-60, 50)];
    LblTitle.text=[ArraySectionTitle objectAtIndex:section];
    [ViewHeader addSubview:LblTitle];
 
    
    UITapGestureRecognizer  *TapGesture   = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HeaderTappedAction:)];
    [ViewHeader addGestureRecognizer:TapGesture];

    return ViewHeader;
}
-(void)HeaderTappedAction:(UITapGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.view.tag==0) {
        
        NSLog(@"CALL REPORT INCIDENT");
        
        UIStoryboard *mainStoryboard;
        if (IS_iPHONE)  mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
        else      mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
        
        PlanTVC *planVC = (PlanTVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"PlanTVC"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[planVC] animated: NO ];
        [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        
    }else  if (gestureRecognizer.view.tag==2) {
        
        NSLog(@"CALL REPORT INCIDENT");
        
        UIStoryboard *mainStoryboard;
        if (IS_iPHONE)  mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
        else      mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
        
        ReportIncidentTVC *reportVC = (ReportIncidentTVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"reportVC"];
        UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
        [navController setViewControllers: @[reportVC] animated: NO ];
        [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
    
    }else if (gestureRecognizer.view.tag==5)
    {
        lavasaAppDelegate *appDelegate = (lavasaAppDelegate *)[[UIApplication sharedApplication] delegate];
        LoginVC *login=[[LoginVC alloc]init];
        appDelegate.self.window.rootViewController=[[UINavigationController alloc]initWithRootViewController:login];
       
        [FBSession.activeSession closeAndClearTokenInformation];   //TO CLEAR THE FB SESSION
        
        [[GPPSignIn sharedInstance] signOut];   //TO CLEAR THE FB SESSION

        
    }
    else if ([ArrayBool objectAtIndex:gestureRecognizer.view.tag]==[NSNumber numberWithBool:YES]) {
       [ ArrayBool replaceObjectAtIndex:gestureRecognizer.view.tag withObject:[NSNumber numberWithBool:NO]];
    }else  [ ArrayBool replaceObjectAtIndex:gestureRecognizer.view.tag withObject:[NSNumber numberWithBool:YES]];
      [firstTableView reloadSections:[NSIndexSet indexSetWithIndex:gestureRecognizer.view.tag] withRowAnimation:UITableViewRowAnimationFade];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
	if (nil == cell)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
	}
    NSArray *content = [DictSectionItems valueForKey:[ArraySectionTitle objectAtIndex:indexPath.section]];
    cell.textLabel.text = [content objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:[content objectAtIndex:indexPath.row]];
    cell.backgroundColor=[UIColor colorWithRed: 241.0f/255.0f green: 247.0f/255.0f blue: 248.0f/255.0f alpha:1.0f];

    UIView *customColorView = [[UIView alloc] init];
    customColorView.backgroundColor = [UIColor colorWithRed:224/255.0
                                                      green:235/255.0
                                                       blue:238/255.0
                                                      alpha:1.0];
    cell.selectedBackgroundView =  customColorView;
	return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWRevealViewController *revealController = [self revealViewController];
    UIViewController *frontViewController = revealController.frontViewController;
    UINavigationController *frontNavigationController =nil;
    
    if ( [frontViewController isKindOfClass:[UINavigationController class]] )
        frontNavigationController = (id)frontViewController;
    NSInteger row = indexPath.row;
	// Here you'd implement some of your own logic... I simply take for granted that the first row (=0) corresponds to the "FrontViewController".
	if (row == 0)
	{
   		// Now let's see if we're not attempting to swap the current frontViewController for a new instance of ITSELF, which'd be highly redundant.
        if ( ![frontNavigationController.topViewController isKindOfClass:[AttractionTabVC class]] )
        {
            UIStoryboard *mainStoryboard;
            if (IS_iPad)  mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle: nil];
            else mainStoryboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle: nil];
            
            AttractionTabVC *AttTabVC = (AttractionTabVC*)[mainStoryboard instantiateViewControllerWithIdentifier: @"AttractionTabVC"];
         
			UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:AttTabVC];
			[revealController setFrontViewController:navigationController animated:YES];
        }
		// Seems the user attempts to 'switch' to exactly the same controller he came from!
		else
		{
            [revealController revealToggleAnimated:YES];
		}
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
