//
//  BBSearchViewController.m
//  BukBench
//
//  Created by Dmitry on 12/24/12.
//  Copyright (c) 2012 Dmitry. All rights reserved.
//

#import "BBSearchViewController.h"
#import "BBListOfBooksViewController.h"

#define EMPTY_DATA 2 //book not found in openlibrary.com database

@interface BBSearchViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtSearchBox;
@property (nonatomic, strong) NSString *searchString;
@property (nonatomic, strong) NSArray *fetchedBooks;
@end

@implementation BBSearchViewController
@synthesize txtSearchBox;
@synthesize fetchedBooks;
@synthesize searchString;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)userSelectedSearchBox:(UITextField *)sender
{
    sender.text = @"";
    sender.textColor = [UIColor blackColor];
}


- (IBAction)bookIsEnteredInSearchBox:(UITextField *)sender
{
    self.searchString = sender.text;
    BBISBNdbClient *client = [[BBISBNdbClient alloc] init];
    NSURL *isbndbQueryURL = [client formQueryUrlForTitle:self.searchString];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    dispatch_queue_t backgroundQueue = dispatch_queue_create("serverCallQueue", NULL);
    dispatch_async(backgroundQueue, ^(void){
       NSData *isbndbBookData = [NSData dataWithContentsOfURL:isbndbQueryURL];
       NSArray *isbns = [client extractISBNsFromData:isbndbBookData];
       NSMutableArray *openLibBooks = [NSMutableArray array];
       
       for(NSString *isbn in isbns) {
           NSURL *openLibQueryURL = [BBOpenLibraryClient formQueryURLForISBN:isbn];
           NSData *openLibBookData = [NSData dataWithContentsOfURL:openLibQueryURL];
           
           if([openLibBookData length] > EMPTY_DATA) {
               NSDictionary *openLibBook = [NSJSONSerialization JSONObjectWithData:openLibBookData
                                                                           options:0
                                                                             error:nil];
               [openLibBooks addObject:openLibBook];
           }
           
           self.fetchedBooks = openLibBooks;
           self.navigationItem.rightBarButtonItem = nil;
       }
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self performSegueWithIdentifier:@"Show list of books" sender:self];
        });
    });
    client = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Show list of books"]) {
        BBListOfBooksViewController *listOfBooksVC = (BBListOfBooksViewController *)segue.destinationViewController;
        [listOfBooksVC setListOfBooks:self.fetchedBooks];
        listOfBooksVC.navigationItem.title = self.searchString;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.txtSearchBox resignFirstResponder];
    return YES;
}

@end