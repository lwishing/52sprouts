//
//  FeedTableViewController.h
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/18/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <Parse/Parse.h>

@interface FeedTableViewController : PFQueryTableViewController

@property (weak, nonatomic) IBOutlet UIButton *ingredientBanner;

@end
