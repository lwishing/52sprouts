//
//  IngredientInfoViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/14/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "IngredientInfoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Utility.h"

@interface IngredientInfoViewController ()

@end

@implementation IngredientInfoViewController

@synthesize headerView, headerText, scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    int padding = 15;
    int x = 10;
    int y = 60;
    int width = 300;
    int headerHeight = 24;
    int inset = 8;
    
    //NSArray *objects = [[NSArray alloc] initWithObjects:@"name", @"description", @"seasonStart", @"seasonEnd", @"nutrients", @"whenBuying", @"storing", @"pairsWith", @"preparation", @"substitutes", nil];
    
    //get the ingrediend from the shared data
    PFObject *ingredient = [[Utility sharedInstance] getCurrentIngredient];
    
    //set the banner
    [headerText setFont:[[Utility sharedInstance] bannerFont]];
    [[headerView superview] bringSubviewToFront:headerView];
    [headerText setText:[NSString stringWithFormat:@"ALL ABOUT %@", [[ingredient objectForKey:@"name"] uppercaseString]]];
    
    //set title bar
    [self setTitle:[ingredient objectForKey:@"name"]];
    
    //back button
    UIImage *backButtonHomeImage = [[UIImage imageNamed:@"back_arrow.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 4)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonHomeImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    //DESCRIPTION
    
    //container uiview
    UIView *descriptionView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, 0)];
    [descriptionView setBackgroundColor:[UIColor whiteColor]];

    //description text
    UITextView *descriptionText = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    descriptionText.text = [ingredient objectForKey:@"description"];
    [descriptionText setFont:[[Utility sharedInstance] bodyFont]];
    [descriptionText setTextColor:[[Utility sharedInstance] greyColor]];
    [descriptionText setUserInteractionEnabled:NO];
    [descriptionText setBackgroundColor:[UIColor clearColor]];

    [descriptionView addSubview:descriptionText];
    
    //resize textview to fit the content
    CGRect descriptionFrame = descriptionText.frame;
    descriptionFrame.size.height = descriptionText.contentSize.height;
    descriptionText.frame = descriptionFrame;
    
    //add container view to scrollview
    [scrollView addSubview: descriptionView];
    
    //resize containerview to fit everything
    [descriptionView resizeToFitSubviews];
    
    //adjust y to new start point
    y += descriptionView.frame.size.height;
    
    
    //SEASON
    
    //container uiview
    UIView *seasonView = [[UIView alloc] initWithFrame:CGRectMake(x, y + padding, width, 0)];
    [seasonView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *seasonHeader = [[UILabel alloc] initWithFrame:CGRectMake(inset, inset, 280, headerHeight)];
    seasonHeader.text = @"In Season";
    [seasonHeader setFont:[[Utility sharedInstance] headerFont]];
    [seasonHeader setTextColor:[[Utility sharedInstance] greenColor]];
    
    //season text
    UITextView *seasonText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    seasonText.text = [NSString stringWithFormat:@"%@ through %@", [ingredient objectForKey:@"seasonStart"], [ingredient objectForKey:@"seasonEnd"]];
    [seasonText setFont:[[Utility sharedInstance] bodyFont]];
    [seasonText setTextColor:[[Utility sharedInstance] greyColor]];
    [seasonText setUserInteractionEnabled:NO];
    [seasonText setBackgroundColor:[UIColor clearColor]];
    
    [seasonView addSubview:seasonHeader];
    [seasonView addSubview:seasonText];
    
    //resize textview to fit the content
    CGRect seasonFrame = seasonText.frame;
    seasonFrame.size.height = seasonText.contentSize.height;
    seasonText.frame = seasonFrame;
    
    //add container view to scrollview
    [scrollView addSubview: seasonView];
    
    //resize containerview to fit everything
    [seasonView resizeToFitSubviews];
    
    //adjust y to new start point
    y += seasonView.frame.size.height + padding;
    
    //NUTRIENT
    
    //container uiview
    UIView *nutrientView = [[UIView alloc] initWithFrame:CGRectMake(x, y + padding, width, 0)];
    [nutrientView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *nutrientHeader = [[UILabel alloc] initWithFrame:CGRectMake(inset, inset, 280, headerHeight)];
    nutrientHeader.text = @"Nutrition Facts";
    [nutrientHeader setFont:[[Utility sharedInstance] headerFont]];
    [nutrientHeader setTextColor:[[Utility sharedInstance] greenColor]];
    
    //season text
    UITextView *nutrientText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    nutrientText.text = [ingredient objectForKey:@"nutrients"];
    [nutrientText setFont:[[Utility sharedInstance] bodyFont]];
    [nutrientText setTextColor:[[Utility sharedInstance] greyColor]];
    [nutrientText setUserInteractionEnabled:NO];
    [nutrientText setBackgroundColor:[UIColor clearColor]];
    
    [nutrientView addSubview:nutrientHeader];
    [nutrientView addSubview:nutrientText];
    
    //resize textview to fit the content
    CGRect nutrientFrame = nutrientText.frame;
    nutrientFrame.size.height = nutrientText.contentSize.height;
    nutrientText.frame = nutrientFrame;
    
    //add container view to scrollview
    [scrollView addSubview: nutrientView];
    
    //resize containerview to fit everything
    [nutrientView resizeToFitSubviews];
    
    //adjust y to new start point
    y += nutrientView.frame.size.height + padding;
    
    
    //BUYING
    
    //container uiview
    UIView *buyingView = [[UIView alloc] initWithFrame:CGRectMake(x, y + padding, width, 0)];
    [buyingView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *buyingHeader = [[UILabel alloc] initWithFrame:CGRectMake(inset, inset, 280, headerHeight)];
    buyingHeader.text = @"When Buying";
    [buyingHeader setFont:[[Utility sharedInstance] headerFont]];
    [buyingHeader setTextColor:[[Utility sharedInstance] greenColor]];
    
    //when buying text
    UITextView *buyingText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    buyingText.text = [ingredient objectForKey:@"whenBuying"];
    [buyingText setFont:[[Utility sharedInstance] bodyFont]];
    [buyingText setTextColor:[[Utility sharedInstance] greyColor]];
    [buyingText setUserInteractionEnabled:NO];
    [buyingText setBackgroundColor:[UIColor clearColor]];
    
    [buyingView addSubview:buyingHeader];
    [buyingView addSubview:buyingText];
    
    //resize textview to fit the content
    CGRect buyingFrame = buyingText.frame;
    buyingFrame.size.height = buyingText.contentSize.height;
    buyingText.frame = buyingFrame;
    
    //add container view to scrollview
    [scrollView addSubview: buyingView];
    
    //resize containerview to fit everything
    [buyingView resizeToFitSubviews];
    
    //adjust y to new start point
    y += buyingView.frame.size.height + padding;
    
//    NSLog(@"y postion: %i", y);
    
    //STORING
    
    //container uiview
    UIView *storingView = [[UIView alloc] initWithFrame:CGRectMake(x, y + padding, width, 0)];
    [storingView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *storingHeader = [[UILabel alloc] initWithFrame:CGRectMake(inset, inset, 280, headerHeight)];
    storingHeader.text = @"Storing";
    [storingHeader setFont:[[Utility sharedInstance] headerFont]];
    [storingHeader setTextColor:[[Utility sharedInstance] greenColor]];
    
    //when buying text
    UITextView *storingText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    storingText.text = [ingredient objectForKey:@"storing"];
    [storingText setFont:[[Utility sharedInstance] bodyFont]];
    [storingText setTextColor:[[Utility sharedInstance] greyColor]];
    [storingText setUserInteractionEnabled:NO];
    [storingText setBackgroundColor:[UIColor clearColor]];
    
    [storingView addSubview:storingHeader];
    [storingView addSubview:storingText];
    
    //resize textview to fit the content
    CGRect storingFrame = storingText.frame;
    storingFrame.size.height = storingText.contentSize.height;
    storingText.frame = storingFrame;
    
    //add container view to scrollview
    [scrollView addSubview: storingView];
    
    //resize containerview to fit everything
    [storingView resizeToFitSubviews];
    
    //adjust y to new start point
    y += storingView.frame.size.height + padding;
    
    
    //PAIRS WITH
    
    //container uiview
    UIView *pairsView = [[UIView alloc] initWithFrame:CGRectMake(x, y + padding, width, 0)];
    [pairsView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *pairsHeader = [[UILabel alloc] initWithFrame:CGRectMake(inset, inset, 280, headerHeight)];
    pairsHeader.text = @"Pairs With";
    [pairsHeader setFont:[[Utility sharedInstance] headerFont]];
    [pairsHeader setTextColor:[[Utility sharedInstance] greenColor]];
    
    //when buying text
    UITextView *pairsText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    pairsText.text = [[ingredient objectForKey:@"pairsWith"] componentsJoinedByString:@", "];
    [pairsText setFont:[[Utility sharedInstance] bodyFont]];
    [pairsText setTextColor:[[Utility sharedInstance] greyColor]];
    [pairsText setUserInteractionEnabled:NO];
    [pairsText setBackgroundColor:[UIColor clearColor]];
    
    [pairsView addSubview:pairsHeader];
    [pairsView addSubview:pairsText];
    
    //resize textview to fit the content
    CGRect pairsFrame = pairsText.frame;
    pairsFrame.size.height = pairsText.contentSize.height;
    pairsText.frame = pairsFrame;
    
    //add container view to scrollview
    [scrollView addSubview: pairsView];
    
    //resize containerview to fit everything
    [pairsView resizeToFitSubviews];
    
    //adjust y to new start point
    y += pairsView.frame.size.height + padding;
    
    //PREPARATION
    
    //container uiview
    UIView *preparationView = [[UIView alloc] initWithFrame:CGRectMake(x, y + padding, width, 0)];
    [preparationView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *preparationHeader = [[UILabel alloc] initWithFrame:CGRectMake(inset, inset, 280, headerHeight)];
    preparationHeader.text = @"Preparation";
    [preparationHeader setFont:[[Utility sharedInstance] headerFont]];
    [preparationHeader setTextColor:[[Utility sharedInstance] greenColor]];
    
    //when buying text
    UITextView *preparationText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    preparationText.text = [[ingredient objectForKey:@"preparation"] componentsJoinedByString:@", "];
    [preparationText setFont:[[Utility sharedInstance] bodyFont]];
    [preparationText setTextColor:[[Utility sharedInstance] greyColor]];
    [preparationText setUserInteractionEnabled:NO];
    [preparationText setBackgroundColor:[UIColor clearColor]];
    
    [preparationView addSubview:preparationHeader];
    [preparationView addSubview:preparationText];
    
    //resize textview to fit the content
    CGRect preparationFrame = preparationText.frame;
    preparationFrame.size.height = preparationText.contentSize.height;
    preparationText.frame = preparationFrame;
    
    //add container view to scrollview
    [scrollView addSubview: preparationView];
    
    //resize containerview to fit everything
    [preparationView resizeToFitSubviews];
    
    //adjust y to new start point
    y += preparationView.frame.size.height + padding;
    
    //SUBSTITUTES
    
    //container uiview
    UIView *subsView = [[UIView alloc] initWithFrame:CGRectMake(x, y + padding, width, 0)];
    [subsView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *subsHeader = [[UILabel alloc] initWithFrame:CGRectMake(inset, inset, 280, headerHeight)];
    subsHeader.text = @"Substitutes";
    [subsHeader setFont:[[Utility sharedInstance] headerFont]];
    [subsHeader setTextColor:[[Utility sharedInstance] greenColor]];
    
    //when buying text
    UITextView *subsText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    subsText.text = [[ingredient objectForKey:@"substitutes"] componentsJoinedByString:@", "];
    [subsText setFont:[[Utility sharedInstance] bodyFont]];
    [subsText setTextColor:[[Utility sharedInstance] greyColor]];
    [subsText setUserInteractionEnabled:NO];
    [subsText setBackgroundColor:[UIColor clearColor]];
    
    [subsView addSubview:subsHeader];
    [subsView addSubview:subsText];
    
    //resize textview to fit the content
    CGRect subsFrame = subsText.frame;
    subsFrame.size.height = subsText.contentSize.height;
    subsText.frame = subsFrame;
    
    //add container view to scrollview
    [scrollView addSubview: subsView];
    
    //resize containerview to fit everything
    [subsView resizeToFitSubviews];
    
    //adjust y to new start point
    y += subsView.frame.size.height + padding;
    
//    NSLog(@"y postion: %i", y);

    
    scrollView.contentSize=CGSizeMake(320, y);
    scrollView.contentInset= UIEdgeInsetsMake(0.0,0.0, 30.0,0.0);
    
    // shadow experiment
    for (UIView *subview in [scrollView subviews]) {
        
        if(![subview isKindOfClass:[UIImageView class]]){
        
        NSLog(@"view: %@", subview.description);
        
        CALayer *sublayer = subview.layer;
        
        sublayer.cornerRadius = 5;
        
        sublayer.shadowColor = [UIColor grayColor].CGColor;
        sublayer.shadowOffset = CGSizeMake(0, 0);
        sublayer.shadowRadius = 2.0;
        sublayer.shadowOpacity = .5;
        sublayer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:subview.bounds cornerRadius:5].CGPath; // make sure you set that for better performance
        }
    }
    
    
}

-(void)awakeFromNib {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
