//
//  DetailTabVC.m
//  Lavasa
//
//  Created by Vivek Yadav on 6/17/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "DetailTabVC.h"
#import "AttractionTabVC.h"
@interface DetailTabVC ()

@end

@implementation DetailTabVC

@synthesize Dict;

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//  /  UIViewController *current = tabBarController.navigationController;
//    NSArray *controllerNameArray = [tabBarController.navigationController viewControllers];
//    NSLog(@"current className:%@",[controllerNameArray objectAtIndex:0]);
    
//    if ([viewController isKindOfClass:[UINavigationController class]])
//    {
//        [(UINavigationController *)viewController popToRootViewControllerAnimated:NO];
//    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.delegate=self;
    
    
 //   self.navigationController.navigationBar.hidden=YES;
//    AttractionTabVC *appDelegate = (AttractionTabVC *)[[UIApplication sharedApplication] delegate];
//    NSArray *viewContrlls=[[appDelegate navigationController] viewControllers];
//    NSLog(@"%@",viewContrlls);
//    
//    
//    if([obj isKindOfClass:[ViewController class]] ){
//        [[appDelegate navigationController] popToViewController:obj animated:NO];
//        return;
//    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
//    self.navigationController.navigationBar.hidden=YES;
}
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
