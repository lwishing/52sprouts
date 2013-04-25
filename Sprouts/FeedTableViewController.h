//
//  FeedTableViewController.h
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/18/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <Parse/Parse.h>

@interface FeedTableViewController : PFQueryTableViewController

@property (weak, nonatomic) IBOutlet UIButton *ingredientButton;
@property (weak, nonatomic) IBOutlet PFImageView *ingredientBanner;
@property (weak, nonatomic) IBOutlet PFImageView *ingredientIcon;

@end
