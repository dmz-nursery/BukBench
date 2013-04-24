//
//  BBMeetupSpotDropDownMenu.m
//  BukBench
//
//  Created by Dmitry on 1/6/13.
//  Copyright (c) 2013 Dmitry. All rights reserved.
//

#import "BBMeetupSpotDropDownMenu.h"

@implementation BBMeetupSpotDropDownMenu
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    NSString *text = [[dropdownArray objectAtIndex:0] objectAtIndex:row];
    NSArray *tokens = [text componentsSeparatedByString:@", "];
    cell.textLabel.text = [tokens objectAtIndex:0];
    cell.detailTextLabel.text = [tokens objectAtIndex:1];
    cell.textLabel.font = [UIFont systemFontOfSize:17.0];
    cell.textLabel.textColor = self.textColor;
    return cell;
}
@end
