//
//  BookingPackageVC.m
//  Lavasa
//
//  Created by Vivek Yadav on 6/30/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "BookingPackageVC.h"
#import "BookingTVCell.h"
@interface BookingPackageVC ()
{
    UIPopoverController *popOverForDatePicker;
    UIDatePicker *datepicker;
    NSMutableArray *ArrMembers;
    NSMutableArray *ArrAge,*ArrGender;
}
@property (weak, nonatomic) IBOutlet UITextField *TextFieldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *TextFieldLastName;
@property (weak, nonatomic) IBOutlet UITextField *TextFieldGender;
@property (weak, nonatomic) IBOutlet UITextField *TextFieldAge;

@property (weak, nonatomic) IBOutlet UITextField *TextFieldDate;

#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
@end
@implementation BookingPackageVC

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
    
    ArrMembers=[[NSMutableArray alloc]init];

  ArrGender=[NSMutableArray arrayWithObjects:@"Male",@"Female", nil];
    ArrAge=[[NSMutableArray alloc]init];
    for (int i=1; i<101;i++) {
        [ArrAge addObject:[NSString stringWithFormat:@"%d",i]];
    }
    UIViewController *viewController = [[UIViewController alloc]init];
    UIView *viewForDatePicker = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    
    datepicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    datepicker.datePickerMode = UIDatePickerModeDate;
    datepicker.hidden = NO;
    datepicker.date = [NSDate date];
    [datepicker addTarget:self action:@selector(DateChange:) forControlEvents:UIControlEventValueChanged];
    
    [viewForDatePicker addSubview:datepicker];
    [viewController.view addSubview:viewForDatePicker];
    
    popOverForDatePicker = [[UIPopoverController alloc]initWithContentViewController:viewController];
    [popOverForDatePicker setPopoverContentSize:CGSizeMake(300, 200) animated:NO];
    
   //    popOverForDatePicker.delegate = self;
}

-(void)DateChange :(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    self.TextFieldDate.text =[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[datepicker date]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return ArrMembers.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BookingTVCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    
    BookingTVCell  *BookCell = (BookingTVCell *) cell;
    BookCell.self.CellTextAge.text=[[ArrMembers objectAtIndex:indexPath.row] objectForKey:@"age"];
    BookCell.self.CellTextFirstName.text=[[ArrMembers objectAtIndex:indexPath.row] objectForKey:@"firstname"];
    BookCell.self.CellTextLastName.text=[[ArrMembers objectAtIndex:indexPath.row] objectForKey:@"lastname"];
    BookCell.self.CellTextGender.text=[[ArrMembers objectAtIndex:indexPath.row] objectForKey:@"gender"];
    BookCell.self.lblSerialNo.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"tapped button at row: %@",self.navigationController.viewControllers);
}
#pragma popover delegate
-(void)popoverListSelctedItem:(NSString *)categoryName :(NSString *)CatType
{
    if ([CatType isEqualToString:@"age"]) {
        self.TextFieldAge.text = categoryName;
    }else
    {
        self.TextFieldGender.text = categoryName;
    }
 
     objList=nil;
    [popover dismissPopoverAnimated:YES];
   
}
#pragma textfield methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.TextFieldDate)
    {
        [popOverForDatePicker presentPopoverFromRect:datepicker.frame inView:self.TextFieldDate  permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown| UIPopoverArrowDirectionLeft|UIPopoverArrowDirectionRight) animated:YES];
    }
    else if (textField==self.TextFieldGender  )
    {
        if (objList == nil)
        {
            objList = [[PopoverTableView alloc]initWithStyle:UITableViewStylePlain];
            objList.delegate = self;
            [objList setSizeForPopover:ArrGender:@"gender"];
        }
        
        if (IS_IPAD)
        {
            if ([objList respondsToSelector:@selector(preferredContentSize)])
            {
            }
            else
            {
                objList.contentSizeForViewInPopover = CGSizeMake(objList.contentSizeForViewInPopover.width, 0);
            }
            popover = [[UIPopoverController alloc]initWithContentViewController:objList];
            [popover presentPopoverFromRect:self.TextFieldGender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        else
        {
            [objList setTitle:@"Select category"];
            
            //            objList =[self.storyboard instantiateViewControllerWithIdentifier:@"PopOverList"];
            //            [objList setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            //            [self presentViewController:objList animated:YES completion:nil];
            
            UINavigationController *navControllerList = [[UINavigationController alloc]initWithRootViewController:objList];
            
            [self presentViewController:navControllerList animated:YES completion:^{
                
            }];
        }
        return NO;
    }else if (textField==self.TextFieldAge)
    {
        if (objList == nil)
        {
            objList = [[PopoverTableView alloc]initWithStyle:UITableViewStylePlain];
            objList.delegate = self;
            [objList setSizeForPopover:ArrAge:@"age"];
          
        }
        if (IS_IPAD)
        {
            if ([objList respondsToSelector:@selector(preferredContentSize)])
            {
            }
            else
            {
                objList.contentSizeForViewInPopover = CGSizeMake(objList.contentSizeForViewInPopover.width, 0);
            }
            popover = [[UIPopoverController alloc]initWithContentViewController:objList];
            [popover presentPopoverFromRect:self.TextFieldAge.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        else
        {
            [objList setTitle:@"Select category"];
            
            //            objList =[self.storyboard instantiateViewControllerWithIdentifier:@"PopOverList"];
            //            [objList setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            //            [self presentViewController:objList animated:YES completion:nil];
            
            UINavigationController *navControllerList = [[UINavigationController alloc]initWithRootViewController:objList];
            
            [self presentViewController:navControllerList animated:YES completion:^{
                
            }];
        }
        return NO;
    }
    
    return NO;
}
- (IBAction)AddBtnAction:(id)sender {
   
    [ArrMembers addObject:[[NSDictionary alloc]initWithObjectsAndKeys:self.TextFieldFirstName.text,@"firstname",self.TextFieldLastName.text,@"lastname",self.TextFieldAge.text,@"age",self.TextFieldDate.text,@"date",self.TextFieldGender.text,@"gender", nil]];
    
    [self.tableView reloadData];
}
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)pc {
    popOverForDatePicker = nil;
}
@end
