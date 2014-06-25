//
//  webservice.h
//  News
//
//  Created by Vivek Yadav on 12/23/13.
//  Copyright (c) 2013 Mediaagility. All rights reserved.
//

#import <Foundation/Foundation.h>


// declare our class
//@class webservice;
//
//// define the protocol for the delegate
//@protocol CustomClassDelegate
//
//// define protocol functions that can be used in any class using this delegate
//-(void)FetchResponse:(webservice *)customClass;
//
//@end

@interface webservice : NSObject<NSXMLParserDelegate>
{
      
    NSMutableData *  webData;
    NSString *currentData;
    NSURLConnection * connetion1;
   
}
-(void)Startconnection:(NSString *)urlString;
//@property (nonatomic, assign) id  delegate;
@property (nonatomic, retain)    NSDictionary *responceDic;
@end


//
//// declare our class
//@class CustomClass;
//
//// define the protocol for the delegate
//@protocol CustomClassDelegate
//
//// define protocol functions that can be used in any class using this delegate
//-(void)sayHello:(CustomClass *)customClass;
//
//@end
//
//
//@interface CustomClass : NSObject
//
//// define delegate property
//@property (nonatomic, assign) id  delegate;
//
//// define public functions
//-(void)helloDelegate;


