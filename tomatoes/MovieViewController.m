//
//  MovieViewController.m
//  tomatoes
//
//  Created by Ross Danielson on 1/15/14.
//  Copyright (c) 2014 zynga. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "Movie.h"
#import "SVProgressHUD.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailsViewController.h"

@interface MovieViewController ()

- (void)reload;

@property (nonatomic, strong) NSMutableArray* movies;
@property BOOL connected;

@end

@implementation MovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self reload];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self reload];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Movies";
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [refresh addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    [self reload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.connected) {
        return self.movies.count;
    } else {
        return 1;
    }
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // this should be in MovieCell class...
    if(self.connected) {
        MovieCell * cell = (MovieCell *)[tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
        Movie* theMovie = self.movies[indexPath.row];
        
        cell.titleLabel.text = theMovie.title;
        cell.synopsisLabel.text = theMovie.synopsis;
        cell.castLabel.text = [theMovie castString];
        
        NSURL * url = [[NSURL alloc] initWithString:theMovie.thumb];
        [cell.posterThumb setImageWithURL:url];
        return cell;
    } else {
        UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"DisconnectedCell"];
        cell.textLabel.text = @"No internet connection!";
            return cell;
    }
}

-(void) reload {
    
    [SVProgressHUD showWithStatus:@"LOADING..." maskType:SVProgressHUDMaskTypeBlack];
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        self.movies = [[NSMutableArray alloc] init];
        
        if(connectionError == nil) {
            self.connected = true;
            NSDictionary* object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSArray* movieList = [object objectForKey:@"movies"];
            
            
            for(NSDictionary* movie in movieList) {
                [self.movies addObject:[Movie movieFactory:movie]];
            }
            
            //        NSLog(@"%@", object);
            
            [self.tableView reloadData];
            
            //        [NSThread sleepForTimeInterval:5];

        } else {
            //UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Important" message: @"You are not connected to the internet.  Please try again." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            //[alert show];
            self.connected = false;
        }
        
        [self.refreshControl endRefreshing];
        [SVProgressHUD dismiss];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UITableViewCell *selectedCell = (UITableViewCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
    Movie *movie = self.movies[indexPath.row];
    
    MovieDetailsViewController *detailsViewController = (MovieDetailsViewController *)segue.destinationViewController;
    detailsViewController.movie = movie;
}

@end
