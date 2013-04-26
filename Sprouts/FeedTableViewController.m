//
//  FeedTableViewController.m
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/18/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "FeedTableViewController.h"
#import "Utility.h"

@interface FeedTableViewController ()
@end

@implementation FeedTableViewController

@synthesize ingredientButton = _ingredientButton;
@synthesize ingredientBanner = _ingredientBanner;
@synthesize ingredientIcon = _ingredientIcon;
@synthesize header = _header;

@synthesize ingredientHeaderView = _ingredientHeaderView;

- (id)initWithCoder:(NSCoder *)aCoder {
    self = [super initWithCoder:aCoder];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Load Ingredient
    Utility *util = [Utility sharedInstance];
    PFObject *ingredient = [util getCurrentIngredient];

    // Set banner
    _ingredientBanner.file = (PFFile *)[ingredient objectForKey:@"photo"];
    [_ingredientBanner loadInBackground];

    // Set icon
    _ingredientIcon.file = (PFFile *)[ingredient objectForKey:@"icon"];
    [_ingredientIcon loadInBackground];

}

@end
