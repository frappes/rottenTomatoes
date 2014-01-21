//
//  MovieDetailsViewController.h
//  tomatoes
//
//  Created by Ross Danielson on 1/20/14.
//  Copyright (c) 2014 zynga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailsViewController : UIViewController

@property (nonatomic, weak) Movie* movie;

-(void)populateFromMovie:(Movie*)movie;

@end
