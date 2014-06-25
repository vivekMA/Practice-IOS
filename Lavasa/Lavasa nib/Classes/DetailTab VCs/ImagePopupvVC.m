//
//  ImagePopupvVC.m
//  Lavasa
//
//  Created by Vivek Yadav on 6/20/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "ImagePopupvVC.h"

@interface ImagePopupvVC ()

@end

@implementation ImagePopupvVC
@synthesize StrUrl;
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
    
    
  //  self.Imgpop.alpha = 0.0;
  //  self.Imgpop.frame=CGRectMake(0, self.view.frame.origin.y, 0, 0);
    
     [self.Imgpop  setImageWithURL:[NSURL URLWithString:@"http://3.imimg.com/data3/JS/XI/MY-715382/1-250x250.jpg"] placeholderImage:[UIImage imageNamed:@"loading.png"]];
    
    //  [self.view.window.rootViewController presentModalViewController:modalController animated:NO];
//    [UIView animateWithDuration:0.5
//                     animations:^{ self.Imgpop.alpha = 10.0;
//                         self.Imgpop.frame=self.view.bounds;
//                     
//                     }];
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

//- (IBAction)TapGestureImgAction:(id)sender {
//    
//  
//}

- (IBAction)TapGestureAction:(UITapGestureRecognizer *)sender {
      [self dismissViewControllerAnimated:NO completion:nil];
}
@end
