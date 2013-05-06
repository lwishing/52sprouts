//
//  FeedTableViewController.h
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/18/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "TimelineViewController.h"

@interface FeedTableViewController : TimelineViewController

@property (weak, nonatomic) IBOutlet UIButton *ingredientButton;
@property (weak, nonatomic) IBOutlet PFImageView *ingredientBanner;
@property (weak, nonatomic) IBOutlet PFImageView *ingredientIcon;
@property (weak, nonatomic) IBOutlet UIView *ingredientHeaderView;

@property (weak, nonatomic) IBOutlet UIView *header;
@property (weak, nonatomic) IBOutlet UILabel *titleBanner;
@end
