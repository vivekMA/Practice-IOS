//
//  SharedData.m
//  singletonClassDemo
//
//  Created by Vivek Yadav on 11/13/13.
//  Copyright (c) 2013 Mediaagility. All rights reserved.
//

#import "SharedData.h"

@implementation SharedData

@synthesize Name,UserId,Gender,DOB,DictDetail;
+(SharedData *)sharedObj
{
    static SharedData * obj1=nil;
    
    @synchronized(self)
    {
        if(!obj1)
        {
            obj1 = [[SharedData alloc] init];
             obj1.DictDetail = [NSMutableDictionary dictionary];
        }
    }
    return obj1;
}
@end
