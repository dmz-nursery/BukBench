//
//  BBListOfUsersViewController.h
//  BukBench
//
//  Created by Dmitry on 1/4/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBListOfUsersViewController : UITableViewController
@property (nonatomic, strong) NSDictionary *book;    //openlibrary book dictionary
@property (nonatomic, strong) NSArray* listOfUsers;  //users who own the book
@end
