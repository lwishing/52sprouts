//
//  LikesTableViewController.m
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/18/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "LikesTableViewController.h"
#import "Utility.h"
#import "UIImage+ResizeAdditions.h"

@interface LikesTableViewController ()
@end

@implementation LikesTableViewController

@synthesize profileImage = _profileImage;
@synthesize profileName = _profileName;
@synthesize profileBanner = _profileBanner;
@synthesize header = _header;

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Utility *util = [Utility sharedInstance];
    
    // Access PFUser
    PFUser *currentUser = [PFUser currentUser];
    
    // Display name
    _profileName.text = [NSString stringWithFormat:@"%@%@%@",[currentUser objectForKey:@"firstName"],@" ",[currentUser objectForKey:@"lastName"]];
    _profileName.font = [[Utility sharedInstance] mediumFont];
    _profileName.textColor = [util darkGreyColor];
    
    // Load profile image
    _profileImage.image = [UIImage imageNamed:@"loading_photo.png"];
    PFFile *avatarFile = [currentUser objectForKey:@"profilePic"];
    [avatarFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        // Now that the data is fetched, update the cell's image property.
        _profileImage.image = [[UIImage imageWithData:data] thumbnailImage:200.0f transparentBorder:0.0f cornerRadius:5.0f interpolationQuality:kCGInterpolationDefault];
    }];
    
    _profileBanner.font = [util bannerFont];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Activity"];
    [query whereKey:@"type" equalTo:@"like"];
    [query whereKey:@"fromUser" equalTo:[PFUser currentUser]];
    [query setCachePolicy:kPFCachePolicyNetworkOnly];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        if (!error) {
            // The count request succeeded. Log the count
            switch (count) {
                case 0:
                    _profileBanner.text = @"LIKES";
                    break;
                case 1:
                    _profileBanner.text = @"1 LIKE";
                    break;
                default:
                    _profileBanner.text = [NSString stringWithFormat:@"%d LIKES", count];
                    break;
            }
        } else {
            // The request failed
        }
    }];
}

// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Activity"];
    [query whereKey:@"type" equalTo:@"like"];
    [query whereKey:@"fromUser" equalTo:[PFUser currentUser]];
    [query includeKey:@"sprout"];
    [query includeKey:@"sprout.user"];
    

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
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath object:[object objectForKey:@"sprout"]];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    
    // Sticky header
    CGRect floatingCellFrame = self.header.frame;
    CGRect floatingLabelFrame = self.profileBanner.frame;
    
    // when contentOffset is is more then cellHeight scroll floating cell
    if (scrollView.contentOffset.y > 121.0) {
        floatingCellFrame.origin.y = scrollView.contentOffset.y;
        floatingLabelFrame.origin.y = scrollView.contentOffset.y + 5.0;
    } else {
        floatingCellFrame.origin.y = 121.0;
        floatingLabelFrame.origin.y = 121.0 + 5.0;
    }
    
    self.header.frame = floatingCellFrame;
    self.profileBanner.frame = floatingLabelFrame;
}

@end
