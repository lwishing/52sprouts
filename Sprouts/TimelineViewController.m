//
//  TimelineViewController.m
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/18/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "TimelineViewController.h"
#import "UIImage+ResizeAdditions.h"
#import "TTTTimeIntervalFormatter.h"
#import "Utility.h"
#import <QuartzCore/QuartzCore.h>

@interface TimelineViewController ()
@end

@implementation TimelineViewController

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];
    if (self) {
        // Customize the table

        
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
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLikeOrUnlikePhoto:) name:PAPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLikeOrUnlikePhoto:) name:PAPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidCommentOnPhoto:) name:PAPPhotoDetailsViewControllerUserCommentedOnPhotoNotification object:nil];
    
    
    // Listen to "sproutPosted" event
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sproutPosted:)
                                                 name:@"sproutPosted"
                                               object:nil];
    
    if (NSClassFromString(@"UIRefreshControl")) {
        // Use the new iOS 6 refresh control.
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        
        UIFont *font = [UIFont fontWithName:@"MuseoSans-700" size:14.0];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:font
                                                                    forKey:NSFontAttributeName];
        refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"What's Sprouting?" attributes:attrsDictionary];
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
    
    FeedViewCell *cell = [[FeedViewCell alloc] init];
    PFFile *imageFile = [object objectForKey:@"photo"];
    
    if (imageFile != nil) { // There's a picture!
        cell = (FeedViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
        // Set your placeholder image first
        cell.sproutImage.image = [UIImage imageNamed:@"loading_photo.png"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            // Now that the data is fetched, update the cell's image property.
            cell.sproutImage.image = [UIImage imageWithData:data];
        }];
    } else { // No picture
        cell = (FeedViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FeedCellNoImage"];
    }
    
    // Set delegate & tags
    cell.delegate = self;
    cell.tag = indexPath.row;
    cell.likeButton.tag = indexPath.row;
    
    // BUTTONS
    cell.likeButton.alpha = 0.0f;
    cell.commentButton.alpha = 0.0f;
    
    // Get all activity on Sprout
    PFQuery *query = [Utility queryForActivitiesOnSprout:object cachePolicy:kPFCachePolicyNetworkOnly];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            return;
        }
        
        BOOL isLikedByCurrentUser = NO;
        // List what's going on
        for (PFObject *activity in objects) {
            if ([[[activity objectForKey:@"fromUser"] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                if ([[activity objectForKey:@"type"] isEqualToString:@"like"]) {
                    isLikedByCurrentUser = YES;
                }
            }
            
        }
        
        [cell setLikeStatus:isLikedByCurrentUser];
        
        PFQuery *queryExistingLikes = [PFQuery queryWithClassName:@"Activity"];
        [queryExistingLikes whereKey:@"sprout" equalTo:object];
        [queryExistingLikes whereKey:@"type" equalTo:@"like"];
        [queryExistingLikes setCachePolicy:kPFCachePolicyNetworkOnly];
        [queryExistingLikes countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
            if (!error) {
                // The count request succeeded. Log the count
                [cell.likeButton setTitle:[[NSNumber numberWithInt:count] stringValue] forState:UIControlStateNormal];
            } else {
                // The request failed
                [cell.likeButton setTitle:@"0" forState:UIControlStateNormal];
            }
        }];
        
        [cell.commentButton setTitle:@"0" forState:UIControlStateNormal];
        
        if (cell.likeButton.alpha < 1.0f || cell.commentButton.alpha < 1.0f) {
            [UIView animateWithDuration:0.100f animations:^{
                cell.likeButton.alpha = 1.0f;
                cell.commentButton.alpha = 1.0f;
            }];
        }
    }];
    
    // CELL
    [cell setSproutObject:object];
    
   return cell;
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

#pragma mark - FeedViewCellDelegate

//- (void)feedViewCell:(FeedViewCell *)feedViewCell didTapUserButton:(UIButton *)button user:(PFUser *)user:
//    PAPAccountViewController *accountViewController = [[PAPAccountViewController alloc] initWithStyle:UITableViewStylePlain];
//    [accountViewController setUser:user];
//    [self.navigationController pushViewController:accountViewController animated:YES];
//}

- (void)feedViewCell:(FeedViewCell *)feedViewCell didTapLikeSproutButton:(UIButton *)button sprout:(PFObject *)sprout {
    [feedViewCell shouldEnableLikeButton:NO];
    
    BOOL liked = !button.selected;
    [feedViewCell setLikeStatus:liked];
    
    NSString *originalButtonTitle = button.titleLabel.text;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    
    NSNumber *likeCount = [numberFormatter numberFromString:button.titleLabel.text];
    if (liked) {
        likeCount = [NSNumber numberWithInt:[likeCount intValue] + 1];
//        [[PAPCache sharedCache] incrementLikerCountForPhoto:photo];
    } else {
        if ([likeCount intValue] > 0) {
            likeCount = [NSNumber numberWithInt:[likeCount intValue] - 1];
        }
//        [[PAPCache sharedCache] decrementLikerCountForPhoto:photo];
    }
    
//    [[PAPCache sharedCache] setPhotoIsLikedByCurrentUser:photo liked:liked];
    
    [button setTitle:[numberFormatter stringFromNumber:likeCount] forState:UIControlStateNormal];
    
    if (liked) {
        NSLog(@"LIKED!");
        [Utility likeSproutInBackground:sprout block:^(BOOL succeeded, NSError *error) {
            FeedViewCell *actualFeedCell = (FeedViewCell *)[self tableView:self.tableView viewForHeaderInSection:button.tag];
            [actualFeedCell shouldEnableLikeButton:YES];
            [actualFeedCell setLikeStatus:succeeded];
            
            if (!succeeded) {
                [actualFeedCell.likeButton setTitle:originalButtonTitle forState:UIControlStateNormal];
            }
        }];
    } else {
        NSLog(@"UNLIKED!");
        [Utility unlikeSproutInBackground:sprout block:^(BOOL succeeded, NSError *error) {
            FeedViewCell *actualFeedCell = (FeedViewCell *)[self tableView:self.tableView viewForHeaderInSection:button.tag];
            [actualFeedCell shouldEnableLikeButton:YES];
            [actualFeedCell setLikeStatus:!succeeded];
            
            if (!succeeded) {
                [actualFeedCell.likeButton setTitle:originalButtonTitle forState:UIControlStateNormal];
            }
        }];
    }
}

- (void) feedViewCell:(FeedViewCell *)feedViewCell didTapCommentOnSproutButton:(UIButton *)button sprout:(PFObject *)sprout {
//    PAPPhotoDetailsViewController *photoDetailsVC = [[PAPPhotoDetailsViewController alloc] initWithPhoto:photo];
//    [self.navigationController pushViewController:photoDetailsVC animated:YES];
    NSLog(@"Comment button!");
}

#pragma mark - ()
// selector for when sprout is posted
- (void)sproutPosted:(NSNotification *)note{
    NSLog(@"Sprout! Let's reload the feed!");
    [self loadObjects];
    [self.tableView reloadData];
}

- (void)userDidLikeOrUnlikeSprout:(NSNotification *)note {
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

- (void)userDidCommentOnSprout:(NSNotification *)note {
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

@end
