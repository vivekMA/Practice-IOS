//
//  PlacesLoader.m
//  Lavasa
//
//  Created by Vivek Sehrawat on 6/26/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import "PlacesLoader.h"
#import <CoreLocation/CoreLocation.h>
#import <Foundation/NSJSONSerialization.h>

NSString * const apiURL = @"https://maps.googleapis.com/maps/api/place/";
NSString * const apiKey = @"AIzaSyALby-zmBjk4ZHRPXmyNXcwIJ5Fj39xaTE";

@interface PlacesLoader ()

@property (nonatomic, strong) SuccessHandler successHandler;
@property (nonatomic, strong) ErrorHandler errorHandler;
@property (nonatomic, strong) NSMutableData *responseData;

@end

@implementation PlacesLoader

+ (PlacesLoader *)sharedInstance {
	static PlacesLoader *instance = nil;
	static dispatch_once_t onceToken;
	
	dispatch_once(&onceToken, ^{
		instance = [[PlacesLoader alloc] init];
	});
	
	return instance;
}

- (void)loadPOIsForLocation:(CLLocation *)location radius:(int)radius type:(NSString *)type successHandler:(SuccessHandler)handler errorHandler:(ErrorHandler)errorHandler  {
	
    _responseData = nil;
	_successHandler = handler;
	_errorHandler = errorHandler;
    
	CLLocationDegrees latitude = [location coordinate].latitude;
	CLLocationDegrees longitude = [location coordinate].longitude;
	
    NSMutableString *uri = [NSMutableString stringWithString:apiURL];
    	[uri appendFormat:@"nearbysearch/json?location=%f,%f&radius=%d&sensor=true&types=%@&key=%@", latitude, longitude, radius, type,apiKey];
    
    
//    NSMutableString *uri=[NSMutableString stringWithString:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=28.458189,77.033826&radius=5000&sensor=true&types=establishment&key=AIzaSyA-ibQQ0w_Tkdnz3DmrITlSQaHY5sMcL28"];
    
    NSLog(@"=================%@===========",uri);
    
  	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[uri stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
	
	[request setHTTPShouldHandleCookies:YES];
	[request setHTTPMethod:@"GET"];
	
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	NSLog(@"Starting connection: %@ for request: %@", connection, request);
}
//
//- (void)loadDetailInformation:(Place *)location successHanlder:(SuccessHandler)handler errorHandler:(ErrorHandler)errorHandler {
//	_responseData = nil;
//	_successHandler = handler;
//	_errorHandler = errorHandler;
//	
//	NSMutableString *uri = [NSMutableString stringWithString:apiURL];
//	[uri appendFormat:@"details/json?reference=%@&sensor=true&key=%@", [location reference], apiKey];
//	
//	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[uri stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
//	
//	[request setHTTPShouldHandleCookies:YES];
//	[request setHTTPMethod:@"GET"];
//	
//	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    
//	NSLog(@"Starting connection: %@ for request: %@", connection, request);
//}

#pragma mark - NSURLConnection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    
	if(!_responseData) {
		_responseData = [NSMutableData dataWithData:data];
	} else {
		[_responseData appendData:data];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
    id object = [NSJSONSerialization JSONObjectWithData:_responseData options:NSJSONReadingAllowFragments error:nil];
	
	if(_successHandler) {
		_successHandler(object);
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    
    
	if(_errorHandler) {
		_errorHandler(error);
	}
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


@end
