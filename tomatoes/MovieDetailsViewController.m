//
//  MovieDetailsViewController.m
//  tomatoes
//
//  Created by Ross Danielson on 1/20/14.
//  Copyright (c) 2014 zynga. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController ()

@property (nonatomic, weak) IBOutlet UITextView* summary;
@property (nonatomic, weak) IBOutlet UIImageView* poster;
@property (nonatomic, weak) IBOutlet UILabel* cast;

@end

@implementation MovieDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self populateFromMovie:self.movie];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)populateFromMovie:(Movie *)movie {
    self.summary.text = movie.synopsis;
    
    NSURL * url = [[NSURL alloc] initWithString:movie.big];
    [self.poster setImageWithURL:url];
    
    self.cast.text = [movie castString];
    
    self.title = movie.title;
}

@end
