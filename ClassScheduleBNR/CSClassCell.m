//
//  CSClassCell.m
//  ClassSchedule
//
//  Created by Ted Rogers on 2/16/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import "CSClassCell.h"

@implementation CSClassCell

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
