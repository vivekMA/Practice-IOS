//
//  DetailTab2.m
//  Lavasa
//
//  Created by Vivek Yadav on 6/19/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "DetailTab2.h"
#import "DetailTab2Cell.h"
#import "ImagePopupvVC.h"
@interface DetailTab2 ()

@end

@implementation DetailTab2

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
    // Do any additional setup after loading the view.
    
    self.title=@"Gallery";
    
}
#pragma mark - collectionview delegate methods

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailTab2Cell *cell;
    static NSString *cellIdentifier = @"CellId";
    if (cell==nil)
    {
 cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        
                 }
        [self configureCell:cell atIndexPath:indexPath];
        
    
        return cell;
}
- (void)configureCell:(UICollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
        
        DetailTab2Cell *detailCell = (DetailTab2Cell *) cell;
    
        //detailCell.ImageGallery.image=[UIImage imageNamed:@"PLAN.png"];
    [detailCell.ImageGallery setImageWithURL:[NSURL URLWithString:@"http://3.imimg.com/data3/JS/XI/MY-715382/1-250x250.jpg"] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    
    
            //    attractionCell.btnBook addTarget:self action:() forControlEvents:uicon
    }
-(NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
{
    return 50;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    ImagePopupvVew *popup=[[ImagePopupvVew alloc]initWithFrame:CGRectMake(0,0,UIScreen.mainScreen.bounds.size.width ,UIScreen.mainScreen.bounds.size.height)];
//      [self.navigationController.view addSubview:popup];
//    popup.backgroundColor=[UIColor redColor];
//    [popup ShowImage:@"http://3.imimg.com/data3/JS/XI/MY-715382/1-250x250.jpg"];
 }
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 
    if ([[segue identifier] isEqualToString:@"GoToPopup"])
    {
        
       }
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

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
