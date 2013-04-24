//
//  BBRequestFormViewController.h
//  BukBench
//
//  Created by Dmitry on 1/7/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBUser.h"

@interface BBRequestFormViewController : UIViewController
@property (nonatomic, strong) NSDictionary *requestedBook; //openlibrary book dictionary
@property (nonatomic, strong) BBUser *bookOwner;
@end
