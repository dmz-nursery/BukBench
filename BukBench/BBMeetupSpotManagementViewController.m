//
//  BBMeetupSpotManagementViewController.m
//  BukBench
//
//  Created by Dmitry on 1/6/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import "BBMeetupSpotManagementViewController.h"
#import "BBServer.h" 
#import "BBMeetupSpot.h"
#import "BBMeetupSpotDropDownMenu.h"
#import "BBUser.h"

@interface BBMeetupSpotManagementViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) BBMeetupSpotDropDownMenu *menu;
@property (nonatomic, strong) NSArray *fetchedMeetupSpots;
@property (nonatomic, strong) NSArray *sysUserMeetupSpots;
@end

@implementation BBMeetupSpotManagementViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.menu = [[BBMeetupSpotDropDownMenu alloc] init];
    BBServer *server = [[BBServer alloc] init];
    self.fetchedMeetupSpots = [server allMeetupSpots];
    NSMutableArray *descriptions = [NSMutableArray arrayWithCapacity:
                                    [self.fetchedMeetupSpots count]];;
    for(BBMeetupSpot *spot in self.fetchedMeetupSpots) {
        [descriptions addObject:[spot description]];
    }
    [self.menu makeMenu:self.textField
             titleArray:descriptions
             valueArray:descriptions
             targetView:self.view];
}

- (IBAction)addPressed:(id)sender
{
    NSString *sysUserSelectedSpotTitle = [[self.textField.text componentsSeparatedByString:@", "] objectAtIndex:0];
    for(BBMeetupSpot *spot in self.fetchedMeetupSpots) {
        if([spot.title isEqualToString:sysUserSelectedSpotTitle]) {
            [[BBUser sharedUser] addSpotToMeetupSpots:spot];
            break;
        }
    }
    self.sysUserMeetupSpots = [[BBUser sharedUser].meetupSpots allObjects];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sysUserMeetupSpots count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MeetupSpotCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[self.sysUserMeetupSpots objectAtIndex:indexPath.row] title];
    cell.detailTextLabel.text = [[self.sysUserMeetupSpots objectAtIndex:indexPath.row] subtitle];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
