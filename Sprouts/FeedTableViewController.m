//
//  FeedTableViewController.m
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/18/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "FeedTableViewController.h"
#import "FeedViewCell.h"
#import "UIImage+ResizeAdditions.h"
#import "Utility.h"
#import "TTTTimeIntervalFormatter.h"
#import <QuartzCore/QuartzCore.h>

@interface FeedTableViewController ()
@end

static TTTTimeIntervalFormatter *timeFormatter;

@implementation FeedTableViewController

@synthesize ingredientButton = _ingredientButton;
@synthesize ingredientBanner = _ingredientBanner;
@synthesize ingredientIcon = _ingredientIcon;
@synthesize header = _header;

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // Customize the table
        if (!timeFormatter) {
            timeFormatter = [[TTTTimeIntervalFormatter alloc] init];
            [timeFormatter setUsesAbbreviatedCalendarUnits:YES];
        }
        
        // The className to query on
        self.parseClassName = @"Sprout";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"title";
        
        // Uncomment the following line to specify the key of a PFFile on the PFObject to display in the imageView of the default cell style
         self.imageKey = @"image";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 10;
        
        // If the iOS 6 class, UIRefreshControl, is available, turn off
        // PFQTVC's built-in pull-to-refresh control.
        if (NSClassFromString(@"UIRefreshControl")) {
            self.pullToRefreshEnabled = NO;
        } else {
            self.pullToRefreshEnabled = YES;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Listen to "sproutPosted" event
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sproutPosted:)
                                                 name:@"sproutPosted"
                                               object:nil];
    
    // Load Ingredient
    Utility *util = [Utility sharedInstance];
    PFObject *ingredient = [util getCurrentIngredient];
    
    // Set banner
    _ingredientBanner.file = (PFFile *)[ingredient objectForKey:@"photo"];
    [_ingredientBanner loadInBackground];
    
    // Set icon
    _ingredientIcon.file = (PFFile *)[ingredient objectForKey:@"icon"];
    [_ingredientIcon loadInBackground];
        
    if (NSClassFromString(@"UIRefreshControl")) {
        // Use the new iOS 6 refresh control.
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"What's Sprouting?"];
        refreshControl.tintColor = [UIColor colorWithRed:(53/255.0) green:(135/255.0) blue:(93/255.0) alpha:1.0];
        self.refreshControl = refreshControl;
        
        // Creating view for extending background
        CGRect frame = self.tableView.bounds;
        frame.origin.y = -frame.size.height;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        [imageView setImage:[UIImage imageNamed:@"background.png"]];
        self.tableView.backgroundView = imageView;
        
        // Call refreshControlValueChanged: when the user pulls the table view down.
        [self.refreshControl addTarget:self action:@selector(refreshControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    // NSLog(@"Load THE FEED!");
}

#pragma mark - PFQueryTableViewController

- (void)objectsWillLoad {
    [super objectsWillLoad];
    // This method is called before a PFQuery is fired to get more objects
}

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    // This method is called every time objects are loaded from Parse via the PFQuery
    
    // Tell the refresh control that we're done loading objects.
    if (NSClassFromString(@"UIRefreshControl")) {
        [self.refreshControl endRefreshing];
    }
}

- (void)refreshControlValueChanged:(UIRefreshControl *)refreshControl {
    // The user just pulled down the table view. Start loading data.
    [self loadObjects];
}

#pragma mark - ()
// selector for when sprout is posted
- (void)sproutPosted:(NSNotification *)note{
    NSLog(@"Sprout! Let's reload the feed!");
    [self loadObjects];
    [self.tableView reloadData];
}

// Infinite scroll
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentSize.height - scrollView.contentOffset.y < (self.view.bounds.size.height)) {
        if (![self isLoading]) {
            [self loadNextPage];
        }
    }
    
    /*
    // Sticky header
    CGRect floatingCellFrame = self.header.frame;
    CGFloat floatingCellHeight = floatingCellFrame.size.height + self.ingredientBanner.frame.size.height;
    
    // when contentOffset is is more then cellHeight scroll floating cell
    if (scrollView.contentOffset.y > floatingCellHeight) {
        NSLog(@"%f",scrollView.contentOffset.y);
        floatingCellFrame.origin.y = -scrollView.contentOffset.y + floatingCellHeight;
        
    // Need to add middle case for between floatingCellHeight and cell + banner height
    } else if (scrollView.contentOffset.y < floatingCellHeight) {
        floatingCellFrame.origin.y = floatingCellHeight;
    
    // when contentOffset is less then cellHeight stick it to the top of UITableView
    } else if (scrollView.contentOffset.y < floatingCellHeight) {
        floatingCellFrame.origin.y = 0;
    }

    self.header.frame = floatingCellFrame;
     */
}

 // Override to customize what kind of query to perform on the class. The default is to query for
 // all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
     // Query for Sprouts only related to the current ingredient
     PFObject *ingredient = [[Utility sharedInstance] getCurrentIngredient];
     PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query includeKey:@"user"];
    [query whereKey:@"ingredient" equalTo:ingredient];
    
     // If Pull To Refresh is enabled, query against the network by default.
     if (self.pullToRefreshEnabled) {
         query.cachePolicy = kPFCachePolicyNetworkOnly;
     }
     
     // If no objects are loaded in memory, we look to the cache first to fill the table
     // and then subsequently do a query against the network.
     if (self.objects.count == 0) {
         query.cachePolicy = kPFCachePolicyCacheThenNetwork;
     }
     
     [query orderByDescending:@"createdAt"];
 
    return query;
}

// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the textKey in the object,
// and the imageView being the imageKey in the object.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    
    PFFile *imageFile = [object objectForKey:@"photo"];
    
    if (imageFile != nil) { // There's a picture!
        FeedViewCell *cell = (FeedViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
        
        // Configure the cell
        // User
        cell.userName.text = [[object objectForKey:@"user"] objectForKey:@"firstName"];
        // Set your placeholder image first
        cell.userAvatar.image = [UIImage imageNamed:@"Icon.png"];
        PFFile *avatarFile = [[object objectForKey:@"user"] objectForKey:@"profilePic"];
        [avatarFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            // Now that the data is fetched, update the cell's image property.
            cell.userAvatar.image = [[UIImage imageWithData:data] thumbnailImage:86.0f transparentBorder:0.0f cornerRadius:5.0f interpolationQuality:kCGInterpolationDefault];
        }];
        
        // Sprout
        cell.sproutTitle.text = [object objectForKey:self.textKey];
        cell.sproutDescription.text = [object objectForKey:(@"content")];

        // Shadow
        CALayer *sublayer = [cell.sproutDescription superview].layer;
        sublayer.shadowOffset = CGSizeMake(0, 2);
        sublayer.shadowRadius = 2.0;
        sublayer.shadowColor = [UIColor grayColor].CGColor;
        sublayer.shadowOpacity = 0.5;
        
        // Timestamp
        NSString *timeString = [timeFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:object.createdAt];
        cell.sproutedAt.text = timeString;
        
        // Set your placeholder image first
        cell.sproutImage.image = [UIImage imageNamed:@"loading_photo.png"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            // Now that the data is fetched, update the cell's image property.
            cell.sproutImage.image = [UIImage imageWithData:data];
        }];
        
       return cell;
        
    } else { // No picture!
        FeedViewCell *cell = (FeedViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FeedCellNoImage"];
        
        // Configure the cell
        // User
        cell.userName.text = [[object objectForKey:@"user"] objectForKey:@"firstName"];
        // Set your placeholder image first
        cell.userAvatar.image = [UIImage imageNamed:@"Icon.png"];
        PFFile *avatarFile = [[object objectForKey:@"user"] objectForKey:@"profilePic"];
        [avatarFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            // Now that the data is fetched, update the cell's image property.
            cell.userAvatar.image = [[UIImage imageWithData:data] thumbnailImage:86.0f transparentBorder:0.0f cornerRadius:5.0f interpolationQuality:kCGInterpolationDefault];
        }];
        
        // Sprout
        cell.sproutTitle.text = [object objectForKey:self.textKey];
        cell.sproutDescription.text = [object objectForKey:(@"content")];
        
        // Shadow
        CALayer *sublayer = [cell.sproutDescription superview].layer;
        sublayer.shadowOffset = CGSizeMake(0, 2);
        sublayer.shadowRadius = 2.0;
        sublayer.shadowColor = [UIColor grayColor].CGColor;
        sublayer.shadowOpacity = 0.5;
        
        // Timestamp
        NSString *timeString = [timeFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:object.createdAt];
        cell.sproutedAt.text = timeString;
        return cell;
    }

}

/*
 // Override if you need to change the ordering of objects in the table.
 - (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
 return [self.objects objectAtIndex:indexPath.row];
 }
 */

/*
 // Override to customize the look of the cell that allows the user to load the next page of objects.
 // The default implementation is a UITableViewCellStyleDefault cell with simple labels.
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *CellIdentifier = @"NextPage";
 
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
 if (cell == nil) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
 }
 
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
 cell.textLabel.text = @"Load more...";
 
 return cell;
 }
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedViewCell *cell = (FeedViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}



#pragma mark - UITableViewDataSource

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the object from Parse and reload the table view
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, and save it to Parse
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
