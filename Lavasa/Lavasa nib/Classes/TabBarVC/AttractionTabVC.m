//
//  AttractionTabVC.m
//  Lavasa
//
//  Created by Vivek Yadav on 6/17/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "AttractionTabVC.h"

@interface AttractionTabVC ()

@end

@implementation AttractionTabVC
UIBarButtonItem *ButtonMenu;
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
    
    self.title=@"Attraction";
    self.navigationController.navigationBar.hidden=NO;
  
    

}

-(void)viewWillAppear:(BOOL)animated
{
      SWRevealViewController *revealController = [self revealViewController];
    ButtonMenu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    ButtonMenu.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem = ButtonMenu;

    
    self.navigationController.navigationBar.hidden=YES;

}
-(void)viewWillDisappear:(BOOL)animated{
    
    
   self.navigationController.navigationBar.hidden=NO;

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
