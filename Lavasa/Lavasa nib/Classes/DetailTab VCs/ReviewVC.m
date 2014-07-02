//
//  ReviewVC.m
//  Lavasa
//
//  Created by Vivek Yadav on 6/24/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "ReviewVC.h"
#import "FMDatabase.h"
#import "ReviewTableCell.h"
@interface ReviewVC ()

@end

@implementation ReviewVC
ReviewTableCell *reviewCell;
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
    ArrayData=[[NSMutableArray alloc]init];
    
  }
-(void)viewDidAppear:(BOOL)animated
{
   
    [self GetData];
}
-(void)GetData
{
     [ArrayData removeAllObjects];
    FMDatabase *database = [FMDatabase databaseWithPath:[self databasePath]];
    [database open];
    FMResultSet *results;
    
    results = [database executeQuery:@"SELECT * FROM review ORDER BY id DESC"];
    
      while([results next]) {
   
        [ArrayData addObject:[[NSDictionary alloc]initWithObjectsAndKeys:[results stringForColumn:@"user_profile_name"],@"title",[results stringForColumn:@"rating"],@"rating",[results stringForColumn:@"review"],@"description" ,[results stringForColumn:@"id"],@"id",[results stringForColumn:@"gplus_url"],@"icon",[results stringForColumn:@"user_like"],@"user_like",nil]];
        
          NSLog(@"%@",ArrayData);
    }
    [self.tableviewReview reloadData];
    [database close];
}
-(void)insertData:(NSString *)LikeNumber :(NSString *)RowId
{
    FMDatabase *database = [FMDatabase databaseWithPath:[self databasePath]];
    [database open];
    
    NSString *query=[NSString stringWithFormat:@" UPDATE review_demo SET user_like= %@ where id =%@",LikeNumber,RowId];
    NSLog(@"%@",query);
    BOOL success= [database executeUpdate:query];
    NSLog(success ? @"Inserted" : @"Failed");
    
    
    
    [database close];
    if (success) {
        
        [self GetData];
    }
}
-(NSString *)databasePath{
    
    NSString *documents=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *databasePath=[documents stringByAppendingPathComponent:@"lavasa_web_service.sqlite"];
    
    NSLog(@"%@",databasePath);
    
    NSFileManager *fileManger=[NSFileManager defaultManager];
    if (![fileManger fileExistsAtPath:databasePath]) {
        NSString *bundlePath=[[NSBundle mainBundle]pathForResource:@"lavasa_web_service" ofType:@"sqlite"];
        
        NSLog(@"%@",bundlePath);
        [fileManger copyItemAtPath:bundlePath toPath:databasePath error:nil];
    }
    return  databasePath;
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
    static NSString *CellIdentifier = @"ReviewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
         }
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
  reviewCell = (ReviewTableCell *) cell;
    
    reviewCell.self.LblUserName.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"title"];
    reviewCell.self.LblReview.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"description"];
    [reviewCell.self.ImgProfile setImageWithURL:[NSURL URLWithString:[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    reviewCell.ImgStar.tag=indexPath.row;
    reviewCell.ImgStar.rating=[[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"rating"] floatValue];
    reviewCell.LblLike.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"user_like"];
    
    [reviewCell.BtnLike addTarget:self action:@selector(LikebtnAction:) forControlEvents:UIControlEventTouchUpInside];
    reviewCell.BtnLike.tag=indexPath.row;
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
-(void)LikebtnAction:(id)sender
{
   [self insertData:[NSString stringWithFormat:@"%ld",[[[ArrayData objectAtIndex:[sender tag]] objectForKey:@"user_like"] integerValue]+1] :[[ArrayData objectAtIndex:[sender tag]] objectForKey:@"id"]];
}
- (IBAction)AddReviewAction:(id)sender {
    
    
    
}

- (IBAction)backAction:(id)sender {
     [self dismissViewControllerAnimated:NO completion:nil];
}
@end
