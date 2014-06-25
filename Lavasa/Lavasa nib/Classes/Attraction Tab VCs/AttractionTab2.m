//
//  AttractionTab2.m
//  Lavasa
//
//  Created by Vivek Yadav on 6/17/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "AttractionTab2.h"
#import "DetailTabVC.h"
#import "MenuVC.h"
#import "FMDatabase.h"
#import "DLStarRatingControl.h"
#import "AttractionTVCell.h"
#define KCellDisplay 0;
#define KSelectedCat @"atm"
@interface AttractionTab2 ()

@end

@implementation AttractionTab2
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
    
    namearray=[[NSMutableArray alloc]init];
    Longarray=[[NSMutableArray alloc]init];
    Latarray=[[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.hidden=NO;
    SWRevealViewController *revealController = [self revealViewController];
    
    UIBarButtonItem *ButtonMenu = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reveal-icon.png"] style:UIBarButtonItemStyleBordered target:revealController action:@selector(revealToggle:)];
    ButtonMenu.tintColor=[UIColor blackColor];
    self.navigationItem.leftBarButtonItem = ButtonMenu;
    
    NumCellCount=KCellDisplay;
    
    ArrayCat=[[NSArray alloc]initWithObjects:@"food",@"atm",@"park",@"hospital",@"bus_station", nil];
    ArrayData=[[NSMutableArray alloc]init];
    [self GetData:KSelectedCat];
    [self locationGet];
    
}
-(void)locationGet
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    if ([CLLocationManager locationServicesEnabled])
    {
        [locationManager startUpdatingLocation];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden=NO;
}


#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return ArrayData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"AttractionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
          }
    [self configureCell:cell atIndexPath:indexPath];
    
       
    return cell;
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    AttractionTVCell *attractionCell = (AttractionTVCell *) cell;
    attractionCell.lblCat.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"name"];
    attractionCell.lblAddress.text=[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"address"];
    [attractionCell.ImgViewCat setImageWithURL:[NSURL URLWithString:[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"loading.png"]];
     attractionCell.btnBook.tag=indexPath.row;
     attractionCell.ImgStar.rating = [[[ArrayData objectAtIndex:indexPath.row] objectForKey:@"overall_rating"] floatValue];
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row+1);
    if (ArrayData.count==indexPath.row +1)
    {
        [self GetData:KSelectedCat];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    self.tabBarController.tabBar.hidden=YES;
    if ([[segue identifier] isEqualToString:@"GoToDetail"])
    {
        DetailTabVC *dvc = segue.destinationViewController;
        [SharedData sharedObj].DictDetail=[ArrayData objectAtIndex:[sender tag]];
        
        
        
//           NSLog(@"%d",[sender tag]);
         NSLog(@"%@",[ArrayData objectAtIndex:[sender tag]]);
        NSLog(@"%@",[SharedData sharedObj].DictDetail);
    }
}
#pragma mark - Fetch data from database

-(void)GetData:(NSString *)Str
{
    
    FMDatabase *database = [FMDatabase databaseWithPath:[self databasePath]];
    [database open];
    FMResultSet *results;
  
        results = [database executeQuery:@"SELECT * FROM tbl_places  where place_type=?   order by rowid limit ?,? ",Str,[NSString stringWithFormat:@"%d",NumCellCount],[NSString stringWithFormat:@"%d",NumCellCount+5]];
  
    int i=0;
    while([results next]) {
        i++;
        [ArrayData addObject:[[NSDictionary alloc]initWithObjectsAndKeys:[results stringForColumn:@"place_name"],@"name",[results stringForColumn:@"formatted_address"],@"address",[results stringForColumn:@"icon_url"],@"icon",[results stringForColumn:@"place_type"],@"place_type" ,[results stringForColumn:@"overall_rating"],@"overall_rating" ,nil]];
        
        NSLog(@"%@",ArrayData);
    }
    if (i>0) {
        [self.tableView reloadData];    }
    NumCellCount=NumCellCount+5;
    [database close];
}
-(NSString *)databasePath{
    
    NSString *documents=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *databasePath=[documents stringByAppendingPathComponent:@"Lavesa.db"];
    NSFileManager *fileManger=[NSFileManager defaultManager];
    if (![fileManger fileExistsAtPath:databasePath]) {
        NSString *bundlePath=[[NSBundle mainBundle]pathForResource:@"Lavasa" ofType:@"db"];
        [fileManger copyItemAtPath:bundlePath toPath:databasePath error:nil];
    }
    return  databasePath;
}

-(void)reloaddata
{
    [ArrayData removeAllObjects];
    [TableViewCat reloadData];
    NumCellCount=KCellDisplay;
    
}
- (IBAction)MapButtonClicked:(id)sender {
    
    objhud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    objhud.labelText=@"Loading...";
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/xml?location=%@,%@&radius=2000&distancesensor=false&types=atm&key=AIzaSyALby-zmBjk4ZHRPXmyNXcwIJ5Fj39xaTE",[NSString stringWithFormat:@"%f", coordinateLocal.latitude],[NSString stringWithFormat:@"%f", coordinateLocal.longitude]]]];
    
	connetion1=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self] ;
	webData = [NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
	[webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
	[webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    //  [ShowAlert showMyAlert:@"Network Alert" :@"Slow Network Connection or Error in Network"];
    NSLog(@"didFailWithError");
    objhud.hidden=YES;
    
    NSLog(@"%@", [error localizedDescription]);
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
	[self startParshing];
}
-(void)startParshing
{
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:webData];
	[parser setDelegate:self];
	[parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
	[parser parse];
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	currentData=@"";
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	currentData = [[currentData stringByAppendingString:string] mutableCopy];
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if( [elementName isEqualToString:@"name"])
    {
        [namearray addObject:currentData];
    }
    else  if( [elementName isEqualToString:@"lat"])
    {
        [Latarray addObject:currentData];
    }
    else  if( [elementName isEqualToString:@"lng"])
    {
        [Longarray addObject:currentData];
    }
    
    
}
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    objhud.hidden=YES;
    
    self.motionManager=[[CMMotionManager alloc]init];
    self.motionManager.accelerometerUpdateInterval=.2;
    
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error){
        
        [self outputAccelertionData:accelerometerData.acceleration];
        
        if (error) {
            NSLog(@"%@",error);
        }
    }];
    
    
    //    NSLog(@"%d,%d,%lu",[Longarray count],[Latarray count],(unsigned long)[namearray count]);
    
}

- (NSMutableArray *)geoLocations{
    
    NSMutableArray *locationArray ;
    locationArray = [[NSMutableArray alloc] init];
    ARGeoCoordinate *tempCoordinate;
    CLLocation       *tempLocation;
    
    for (int i=0; i<namearray.count; i++) {
        
        tempLocation = [[CLLocation alloc] initWithLatitude:[[Latarray objectAtIndex:i] floatValue] longitude:[[Longarray objectAtIndex:i] floatValue]];
        tempCoordinate = [ARGeoCoordinate coordinateWithLocation:tempLocation locationTitle:[namearray objectAtIndex:i]];
        
        tempCoordinate.inclination = 0.8;
        [locationArray addObject:tempCoordinate];
        
    }
    return locationArray;
}


- (void)locationClicked:(ARGeoCoordinate *)coordinate{
    //    NSLog(@"%d",  (int)coordinate.distanceFromOrigin);
    
    
}

-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    
    BOOL X_axiz=  [self float:acceleration.x between:-.75 and:.75];
    BOOL Z_axiz=  [self float:acceleration.x between:-.72 and:.70];
    
    [self.motionManager stopAccelerometerUpdates];
    
    if (X_axiz & Z_axiz) { // show Map
        
        SharedData *shared=[SharedData sharedObj];
        shared.MapViewFirst=TRUE;
        
        MapViewController *map=[[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
        
        
        NSLog(@"LatArrary=======%@",Latarray);
        
        map.marrlatArray=Latarray;
        map.marrlongArray=Longarray;
        map.marrNameArray=namearray;
        [map setHidesBottomBarWhenPushed:YES];
        
        [self.navigationController pushViewController:map animated:YES];
        
    }
    else{ // AR
        
        SharedData *shared=[SharedData sharedObj];
        shared.MapViewFirst=FALSE;
        [self showAR];
    }
}
-(void)showAR{
    
    _arViewController = [[ARViewController alloc] initWithDelegate:self];
    _arViewController.showsCloseButton = false;
    [_arViewController setHidesBottomBarWhenPushed:YES];
    [_arViewController setRadarRange:400000.0];
    [_arViewController setOnlyShowItemsWithinRadarRange:YES];
    [self.navigationController pushViewController:_arViewController animated:YES];
    
}

- (void)viewDidAppear:(BOOL)animated{
    _arViewController = nil;
}
- (BOOL)float:(float)aFloat between:(float)minValue and:(float)maxValue {
    if (aFloat >= minValue && aFloat <= maxValue) {
        return YES;
    } else {
        return NO;
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    SharedData *shared=[SharedData sharedObj];
    shared.arrLocation=locations;
    
    [locationManager stopUpdatingLocation];
    location = [locationManager location];
    coordinateLocal = [location coordinate];
    
    [locationManager stopUpdatingLocation];
    locationManager.delegate=Nil;
    
}
@end
