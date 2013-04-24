//
//  BBBookProfileViewController.m
//  BukBench
//
//  Created by Dmitry on 1/3/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import "BBBookProfileViewController.h"
#import "BBUser.h"
#import "BBMeetupSpot.h"
#import "BBServer.h"
#import "BBListOfUsersViewController.h"
#import "OpenLibBook.h"

@interface BBBookProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthor;
@property (weak, nonatomic) IBOutlet UILabel *lblPublished;
@property (weak, nonatomic) IBOutlet UILabel *lblPublisher;
@property (weak, nonatomic) IBOutlet UILabel *lblIsbn;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIToolbar *bottomToolbar;
@end

@implementation BBBookProfileViewController
@synthesize book = _book;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.coverImage.layer setBorderColor:[UIColor darkGrayColor].CGColor];
    [self.coverImage.layer setBorderWidth:1];
    [self updateView];
    self.navigationItem.title = [OpenLibBook titleForBook:self.book];
}

- (void)setBook:(NSDictionary *)book
{
    if(_book != book) _book = book;
    [self updateView];
}

- (void)updateView
{
    self.lblTitle.text = [OpenLibBook titleForBook:self.book];
    self.lblAuthor.text = [OpenLibBook authorForBook:self.book];
    self.lblPublished.text = [OpenLibBook publicationDateForBook:self.book];
    self.lblPublisher.text = [OpenLibBook publisherForBook:self.book];
    self.lblIsbn.text = [OpenLibBook isbn13ForBook:self.book];
    if(!self.lblIsbn.text) self.lblIsbn.text = [OpenLibBook isbn10ForBook:self.book];
    dispatch_queue_t backgroundQueue = dispatch_queue_create("image downloader", NULL);
    dispatch_async(backgroundQueue, ^(void){
        NSURL *imageURL = [NSURL URLWithString:[OpenLibBook coverImageForBookMedium:self.book]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(),^(void) {
            self.coverImage.image = [UIImage imageWithData:imageData];
        });
    });
}

- (IBAction)addToMyBooksPressed:(id)sender
{
    [[BBUser sharedUser] addBookToBookshelf:self.book];
    [(UIBarButtonItem *)sender setTitle:@"Added"];
}

- (IBAction)addToMyReadListPressed:(id)sender
{
    [[BBUser sharedUser] addBookToReadList:self.book];
    [(UIBarButtonItem *)sender setTitle:@"Added"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Show list of users with book"]) {
        //simulate a server request
        BBServer *server = [[BBServer alloc] init];
        NSArray *fetchedUsers = [server usersWithBook:self.book];
        NSMutableArray *canMeet = [NSMutableArray array];
        NSMutableArray *canNotMeet = [NSMutableArray array];
        for(BBUser *user in fetchedUsers) {
            if([user canMeetAtSpots:[BBUser sharedUser].meetupSpots])
                [canMeet addObject:user];
            else
                [canNotMeet addObject:user];
        }
        fetchedUsers = nil;
        fetchedUsers = [NSArray arrayWithObjects:canMeet, canNotMeet, nil];
        [segue.destinationViewController setListOfUsers:fetchedUsers];
        [segue.destinationViewController setBook:self.book];
    }
}

@end
