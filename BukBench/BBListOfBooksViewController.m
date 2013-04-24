//
//  BBListOfBooksViewController.m
//  BukBench
//
//  Created by Dmitry on 12/26/12.
//  Copyright (c) 2012 Dmitry. All rights reserved.
//

#import "BBListOfBooksViewController.h"
#import "BBOpenLibraryClient.h"
#import "BBBookProfileViewController.h"
#import "OpenLibBook.h"

@interface BBListOfBooksViewController ()
@end

@implementation BBListOfBooksViewController
@synthesize listOfBooks = _listOfBooks;

- (void) setListOfBooks:(NSArray *)listOfBooks
{
    if(_listOfBooks != listOfBooks) _listOfBooks = listOfBooks;
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listOfBooks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //setup the book cell
    NSDictionary *currentBook = [self.listOfBooks objectAtIndex:indexPath.row];
    NSString *title = [OpenLibBook titleForBook:currentBook];
    cell.textLabel.text = (title)? title : @"Untitled";
    NSString *author = [OpenLibBook authorForBook:currentBook];
    author = [OpenLibBook openLibIdForBook:currentBook]; //for testing purposes
    cell.detailTextLabel.text = (author)? [@"by " stringByAppendingString:author] : @"Unknown";
    dispatch_queue_t backgroundQueue = dispatch_queue_create("image downloader", NULL);
    dispatch_async(backgroundQueue, ^{
        NSURL *imageURL = [NSURL URLWithString:[OpenLibBook coverImageForBookSmall:currentBook]];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(),^(void) {
            cell.imageView.image = [UIImage imageWithData:imageData];
        });
    });
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Show book profile"]){
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
        [segue.destinationViewController setBook:[self.listOfBooks objectAtIndex:indexPath.row]];
    }
}

@end
