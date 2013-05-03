//
//  FeedTableViewController.m
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/18/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "FeedTableViewController.h"
#import "Utility.h"
#import <QuartzCore/QuartzCore.h>

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

    //top shadow


    // Set banner
//    _ingredientBanner.file = (PFFile *)[ingredient objectForKey:@"photo"];
//    [_ingredientBanner loadInBackground];
    
    PFFile *bannerFile = (PFFile *)[ingredient objectForKey:@"photo"];
    [bannerFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        // Now that the data is fetched, update the cell's image property.
        _ingredientBanner.image = [UIImage imageWithData:data];
        
        UIView *topShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 67.0, _ingredientBanner.bounds.size.width, 50)];
        CAGradientLayer *topShadow = [CAGradientLayer layer];
        topShadow.frame = CGRectMake(0, 0, _ingredientBanner.bounds.size.width, 50);
        topShadow.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor colorWithWhite:0.0 alpha:0.8f] CGColor], nil];
        [topShadowView.layer insertSublayer:topShadow atIndex:0];
        
        [_ingredientBanner addSubview:topShadowView];
    }];

    // Set icon
    _ingredientIcon.file = (PFFile *)[ingredient objectForKey:@"icon"];
    [_ingredientIcon loadInBackground];
    


}

@end
