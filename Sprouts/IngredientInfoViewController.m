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
    
    //get the ingrediend from the shared data
    PFObject *ingredient = [[Utility sharedInstance] getCurrentIngredient];
    
    //set the banner
    [headerText setFont:[UIFont fontWithName:@"MuseoSans-500" size:14.0]];
    [[headerView superview] bringSubviewToFront:headerView];
    [headerText setText:[NSString stringWithFormat:@"ALL ABOUT %@", [[ingredient objectForKey:@"name"] uppercaseString]]];
    
    //set title bar
    [self setTitle:[ingredient objectForKey:@"name"]];
    

    //DESCRIPTION
    
    //container uiview
    UIView *descriptionView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, 0)];
    [descriptionView setBackgroundColor:[UIColor whiteColor]];

    //description text
    UITextView *descriptionText = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    descriptionText.text = [ingredient objectForKey:@"description"];
    [descriptionText setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    [descriptionText setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1.0]];
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
    
//    NSLog(@"y postion: %i", y);
    
    //SEASON
    
    //container uiview
    UIView *seasonView = [[UIView alloc] initWithFrame:CGRectMake(x, y + padding, width, 0)];
    [seasonView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *seasonHeader = [[UILabel alloc] initWithFrame:CGRectMake(inset, inset, 280, headerHeight)];
    seasonHeader.text = @"In Season";
    [seasonHeader setFont:[UIFont fontWithName:@"MuseoSans-300" size:20.0]];
    [seasonHeader setTextColor:[UIColor colorWithRed:(55/255.0) green:(140/255.0) blue:(96/255.0) alpha:1.0]];
    
    //season text
    UITextView *seasonText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    seasonText.text = [NSString stringWithFormat:@"%@ through %@", [ingredient objectForKey:@"seasonStart"], [ingredient objectForKey:@"seasonEnd"]];
    [seasonText setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    [seasonText setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1.0]];
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
    
//    NSLog(@"y postion: %i", y);
    
    //BUYING
    
    //container uiview
    UIView *buyingView = [[UIView alloc] initWithFrame:CGRectMake(x, y + padding, width, 0)];
    [buyingView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *buyingHeader = [[UILabel alloc] initWithFrame:CGRectMake(inset, inset, 280, headerHeight)];
    buyingHeader.text = @"When Buying";
    [buyingHeader setFont:[UIFont fontWithName:@"MuseoSans-300" size:20.0]];
    [buyingHeader setTextColor:[UIColor colorWithRed:(55/255.0) green:(140/255.0) blue:(96/255.0) alpha:1.0]];
    
    //when buying text
    UITextView *buyingText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    buyingText.text = [ingredient objectForKey:@"whenBuying"];
    [buyingText setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    [buyingText setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1.0]];
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
    [storingHeader setFont:[UIFont fontWithName:@"MuseoSans-300" size:20.0]];
    [storingHeader setTextColor:[UIColor colorWithRed:(55/255.0) green:(140/255.0) blue:(96/255.0) alpha:1.0]];
    
    //when buying text
    UITextView *storingText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    storingText.text = [ingredient objectForKey:@"storing"];
    [storingText setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    [storingText setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1.0]];
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
    
//    NSLog(@"y postion: %i", y);
    
    //PAIRS WITH
    
    //container uiview
    UIView *pairsView = [[UIView alloc] initWithFrame:CGRectMake(x, y + padding, width, 0)];
    [pairsView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *pairsHeader = [[UILabel alloc] initWithFrame:CGRectMake(inset, inset, 280, headerHeight)];
    pairsHeader.text = @"Pairs With";
    [pairsHeader setFont:[UIFont fontWithName:@"MuseoSans-300" size:20.0]];
    [pairsHeader setTextColor:[UIColor colorWithRed:(55/255.0) green:(140/255.0) blue:(96/255.0) alpha:1.0]];
    
    //when buying text
    UITextView *pairsText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    pairsText.text = [[ingredient objectForKey:@"pairsWith"] componentsJoinedByString:@", "];
    [pairsText setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    [pairsText setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1.0]];
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
    
//    NSLog(@"y postion: %i", y);
    
    //PREPARATION
    
    //container uiview
    UIView *preparationView = [[UIView alloc] initWithFrame:CGRectMake(x, y + padding, width, 0)];
    [preparationView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *preparationHeader = [[UILabel alloc] initWithFrame:CGRectMake(inset, inset, 280, headerHeight)];
    preparationHeader.text = @"Preparation";
    [preparationHeader setFont:[UIFont fontWithName:@"MuseoSans-300" size:20.0]];
    [preparationHeader setTextColor:[UIColor colorWithRed:(55/255.0) green:(140/255.0) blue:(96/255.0) alpha:1.0]];
    
    //when buying text
    UITextView *preparationText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    preparationText.text = [[ingredient objectForKey:@"preparation"] componentsJoinedByString:@", "];
    [preparationText setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    [preparationText setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1.0]];
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
    
//    NSLog(@"y postion: %i", y);
    
    //SUBSTITUTES
    
    //container uiview
    UIView *subsView = [[UIView alloc] initWithFrame:CGRectMake(x, y + padding, width, 0)];
    [subsView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *subsHeader = [[UILabel alloc] initWithFrame:CGRectMake(inset, inset, 280, headerHeight)];
    subsHeader.text = @"Substitutes";
    [subsHeader setFont:[UIFont fontWithName:@"MuseoSans-300" size:20.0]];
    [subsHeader setTextColor:[UIColor colorWithRed:(55/255.0) green:(140/255.0) blue:(96/255.0) alpha:1.0]];
    
    //when buying text
    UITextView *subsText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    subsText.text = [[ingredient objectForKey:@"substitutes"] componentsJoinedByString:@", "];
    [subsText setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    [subsText setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1.0]];
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
    
    // shadow experiement
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
