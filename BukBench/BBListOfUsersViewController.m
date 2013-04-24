//
//  BBListOfUsersViewController.m
//  BukBench
//
//  Created by Dmitry on 1/4/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import "BBListOfUsersViewController.h"
#import "BBUser.h"
#import "BBRequestFormViewController.h"  
#import "OpenLibBook.h"

@implementation BBListOfUsersViewController
@synthesize listOfUsers = _listOfUsers;
@synthesize book = _book;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.title = [OpenLibBook titleForBook:self.book];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.listOfUsers count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.listOfUsers objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)    return @"Users with matching spots";
    else                return @"Other users";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UserCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
    }
    BBUser *user = [[self.listOfUsers objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Show request form"]) {
        NSIndexPath* indexPath = [self.tableView indexPathForCell:sender];
        BBUser *bookOwner = [[self.listOfUsers objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        [segue.destinationViewController setRequestedBook:self.book];
        [segue.destinationViewController setBookOwner:bookOwner];
    }
}


@end
