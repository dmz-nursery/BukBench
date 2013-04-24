//
//  BBListOfBooksViewController.h
//  BukBench
//
//  Created by Dmitry on 12/26/12.
//  Copyright (c) 2012 Dmitry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBListOfBooksViewController : UITableViewController
@property (nonatomic, strong) NSArray *listOfBooks;     //that match search parameters
@end
