//
//  BBBookViewCell.m
//  BukBench
//
//  Created by Dmitry on 12/27/12.
//  Copyright (c) 2012 Dmitry. All rights reserved.
//

#import "BBBookViewCell.h"

@implementation BBBookViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
