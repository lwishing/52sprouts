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
@synthesize sproutCount = _sproutCount;

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Access PFUser
    PFUser *currentUser = [PFUser currentUser];
    
    // Display name
    _profileName.text = [NSString stringWithFormat:@"%@%@%@",[currentUser objectForKey:@"firstName"],@" ",[currentUser objectForKey:@"lastName"]];
    _profileName.font = [[Utility sharedInstance] mediumFont];
//    _profileName.textColor = [[Utility sharedInstance] greenColor];
    
    // Load profile image
    _profileImage.image = [UIImage imageNamed:@"loading_photo.png"];
    PFFile *avatarFile = [currentUser objectForKey:@"profilePic"];
    [avatarFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        // Now that the data is fetched, update the cell's image property.
        _profileImage.image = [[UIImage imageWithData:data] thumbnailImage:200.0f transparentBorder:0.0f cornerRadius:5.0f interpolationQuality:kCGInterpolationDefault];
    }];
}

// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    
    PFQuery *queryForLikes = [PFQuery queryWithClassName:@"Activity"];
    [queryForLikes whereKey:@"type" equalTo:@"like"];
    [queryForLikes whereKey:@"fromUser" equalTo:[PFUser currentUser]];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Sprout"];
    [query includeKey:@"user"];
    [query whereKey:@"user" matchesKey:@"toUser" inQuery:queryForLikes];
    
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

@end
