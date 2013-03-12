//
//  CSClassCell.h
//  ClassSchedule
//
//  Created by Ted Rogers on 2/16/13.
//  Copyright (c) 2013 Ted Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSClassCell : UITableViewCell
{
}
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UILabel *instructorLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreInfoButton;
@property (weak, nonatomic) IBOutlet UIImageView *moreInfoSeparator;


@end
