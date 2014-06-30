//
//  UIApplication+AppDimension.h
//  Lavasa
//
//  Created by Vivek Sehrawat on 6/30/14.
//  Copyright (c) 2014 Mediaagility. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (AppDimension)

+(CGSize) currentSize;
+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation;
+(CGRect)currentScreenBoundsDependOnOrientation;

@end
