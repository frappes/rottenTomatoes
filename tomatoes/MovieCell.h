//
//  MovieCell.h
//  tomatoes
//
//  Created by Ross Danielson on 1/20/14.
//  Copyright (c) 2014 zynga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel * titleLabel;
@property (nonatomic, weak) IBOutlet UILabel * synopsisLabel;
@property (nonatomic, weak) IBOutlet UILabel * castLabel;
@property (nonatomic, weak) IBOutlet UIImageView * posterThumb;

@end
