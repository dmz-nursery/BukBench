//
//  BBBookProfileViewController.h
//  BukBench
//
//  Created by Dmitry on 1/3/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>  //for UIImageView border

@interface BBBookProfileViewController : UIViewController
@property (nonatomic, strong) NSDictionary *book;  //user selected book; openlibrary book dictionary

@end
