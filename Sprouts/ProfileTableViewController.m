//
//  ProfileTableViewController.m
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/18/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "Utility.h"

@interface ProfileTableViewController ()
@end

@implementation ProfileTableViewController

@synthesize profileImage = _profileImage;
@synthesize profileName = _profileName;


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
    self.profileName.text = [NSString stringWithFormat:@"%@%@%@",[currentUser objectForKey:@"firstName"],@" ",[currentUser objectForKey:@"lastName"]];
    
    // Load profile image
    self.profileImage.file = (PFFile *)[currentUser objectForKey:@"profilePic"]; // remote image
    [self.profileImage loadInBackground];
}

// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.
- (PFQuery *)queryForTable {
    
    // Query for Sprouts only related to the current ingredient
    PFObject *ingredient = [[Utility sharedInstance] getCurrentIngredient];
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query includeKey:@"user"];
    [query whereKey:@"ingredient" equalTo:ingredient];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    
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
