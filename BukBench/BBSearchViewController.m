//
//  BBSearchViewController.m
//  BukBench
//
//  Created by Dmitry on 12/24/12.
//  Copyright (c) 2012 Dmitry. All rights reserved.
//

#import "BBSearchViewController.h"

@interface BBSearchViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchBox;

@end

@implementation BBSearchViewController
@synthesize searchBox;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchBox.delegate = self;
}

- (IBAction)bookEnteredInSearchBox:(id)sender
{
    [searchBox resignFirstResponder];
    NSLog(@"entered book: %@", searchBox.text);
}







- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
