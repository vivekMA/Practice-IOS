//
//  SharedData.h
//  singletonClassDemo
//
//  Created by Vivek Yadav on 11/13/13.
//  Copyright (c) 2013 Mediaagility. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedData : NSObject
@property(nonatomic, strong) NSString * Name;
@property(nonatomic, strong) NSString * UserId;
@property(nonatomic, strong) NSString * Email;
@property(nonatomic, strong) NSString * Gender;
@property(nonatomic, strong) NSString * DOB;

@property BOOL MapViewFirst;

@property (nonatomic, retain) NSArray *arrLocation;

@property (nonatomic, retain) NSMutableDictionary *DictDetail;

+(SharedData *)sharedObj;

@end
