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
@synthesize ingredientHeaderView = _ingredientHeaderView;

@synthesize header = _header;
@synthesize titleBanner = _titleBanner;

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
    
    // Set title
    NSDateFormatter *titleDate = [[NSDateFormatter alloc] init];
    [titleDate setDateFormat:@"M/d"];
    PFObject *week = [util getCurrentWeek];
    
    NSString *text = [NSString stringWithFormat:@"WHAT'S COOKING %@ TO %@ ",
                      [titleDate stringFromDate:[week objectForKey:@"startDate"]],
                      [titleDate stringFromDate:[week objectForKey:@"endDate"]]];
    _titleBanner.text = text;
    _titleBanner.font = [util bannerFont];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];
    
    // Sticky header
    CGRect floatingCellFrame = self.header.frame;
    
    // when contentOffset is is more then cellHeight scroll floating cell
    if (scrollView.contentOffset.y > 116.0) {
        NSLog(@"%f",scrollView.contentOffset.y);
        floatingCellFrame.origin.y = scrollView.contentOffset.y;
    } else {
        floatingCellFrame.origin.y = 116.0;
    }
    
    self.header.frame = floatingCellFrame;
}

@end
