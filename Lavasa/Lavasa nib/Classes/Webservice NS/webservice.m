//
//  webservice.m
//  News
//
//  Created by Vivek Yadav on 12/23/13.
//  Copyright (c) 2013 Mediaagility. All rights reserved.
//
#import "webservice.h"
@implementation webservice
{
}
@synthesize responceDic;
//-(void)helloDelegate
//{
//    // send message the message to the delegate
//    [_delegate FetchResponse:self];
//}
-(void)Startconnection:(NSString *)urlString
{
    
    
    NSLog(@"%@",urlString);
    
NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
 connetion1=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self] ;
	webData = [NSMutableData data];
 
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
 //   [ShowAlert showMyAlert:@"Network Alert" :@"No Internet connection detected"];
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
  
    NSError *myError = nil;
    responceDic=nil;
 responceDic = [NSJSONSerialization JSONObjectWithData:webData options:NSJSONReadingMutableLeaves error:&myError];

    NSLog(@"%@",responceDic  );

    
       
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WebServiceNotification" object:nil];
    
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"buy" object:responceDic];

}
@end



