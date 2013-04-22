//
//  IngredientInfoViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/14/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "IngredientInfoViewController.h"

@interface IngredientInfoViewController ()

@end

@implementation IngredientInfoViewController

@synthesize headerView, descriptionView, seasonView, headerText, descriptionText, seasonText, seasonHeader, buyingText, buyingHeader;

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
    
    //self.scrollView.contentSize = self.scrollView.frame.size;
    
    //set the fonts
    [headerText setFont:[UIFont fontWithName:@"MuseoSans-500" size:14.0]];
    [descriptionText setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    [seasonHeader setFont:[UIFont fontWithName:@"MuseoSans-300" size:20.0]];
    [seasonText setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    [buyingHeader setFont:[UIFont fontWithName:@"MuseoSans-300" size:20.0]];
    [buyingText setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    
    [[headerView superview] bringSubviewToFront:headerView];
    
    //resizeable background image
    //UIImage *backgroundImage = [[UIImage imageNamed:@"contentBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 10, 0)];
    
    //UIImage *background = [UIImage imageNamed: @"contentBackground"];
    //UIImageView *backgroundView = [[UIImageView alloc] initWithImage: background];
    
    //[descriptionView addSubview: backgroundView];
    
    //[descriptionView sendSubviewToBack:backgroundView];
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Ingredient"];
    
    [query getObjectInBackgroundWithId:@"izH3jFduSU"
                                 block:^(PFObject *ingredient, NSError *error) {
                                     if (!error) {
                                         
                                         //set header text to ingredient name
                                         [headerText setText:[NSString stringWithFormat:@"ALL ABOUT %@", [[ingredient objectForKey:@"name"] uppercaseString]]];
                                         
                                         //set description text
                                         [descriptionText setText:[ingredient objectForKey:@"description"]];
                                         
                                         //resize textframe to fit content
                                         CGRect descriptionFrame = descriptionText.frame;
                                         descriptionFrame.size.height = descriptionText.contentSize.height;
                                         descriptionText.frame = descriptionFrame;
                                         
                                         //set season text
                                         [seasonText setText:[NSString stringWithFormat:@"%@ through %@", [ingredient objectForKey:@"seasonStart"], [ingredient objectForKey:@"seasonEnd"]]];
                                         
                                         CGRect seasonFrame = seasonText.frame;
                                         seasonFrame.size.height = seasonText.contentSize.height;
                                         seasonText.frame = seasonFrame;
                                         
                                         //set when buying text
                                         [buyingText setText:[ingredient objectForKey:@"whenBuying"]];
                                         
                                         CGRect buyingFrame = buyingText.frame;
                                         buyingFrame.size.height = buyingText.contentSize.height;
                                         buyingText.frame = buyingFrame;
                                    
                                         
                                         //set title bar's title to ingrediend
                                         [self setTitle:[ingredient objectForKey:@"name"]]; 
                                         
                                         // The get request succeeded. Log the score
                                         NSLog(@"The ingredient is: %@", [ingredient objectForKey:@"name"]);
                                     } else {
                                         // Log details of our failure
                                         NSLog(@"Error: %@", error);
                                     }
                                 }];
    
    

    
    
	// Do any additional setup after loading the view.
    
    //
    //    // get Week object
    //    PFQuery *queryWeek = [PFQuery queryWithClassName:@"Week"];
    //    PFObject *week = [queryWeek getObjectWithId:@"2VMFZOMUiY"];
    //
    //    NSNumber *weekInt = [week objectForKey:@"week"];
    //    NSLog(@"week: %@", weekInt);
    //
    //    NSDate *startDate = [week objectForKey:@"startDate"];
    //    NSLog(@"startDate: %@", startDate);
    //
    //    NSDate *endDate = [week objectForKey:@"endDate"];
    //    NSLog(@"endDate: %@", endDate);
    //
    //    // get ingredient object from the pointer in Week
    //    PFObject *ingredient = [week objectForKey:@"ingredient"];
    //    [ingredient fetchIfNeeded];
    //
    //    NSString *ingredientId = ingredient.objectId;
    //    NSLog(@"ingredientId: %@", ingredientId);
    //
    //    NSString *ingredientName = [ingredient objectForKey:@"name"];
    //    NSLog(@"ingredientName: %@", ingredientName);
    //
    //    NSString *ingredientDescription = [ingredient objectForKey:@"description"];
    //    NSLog(@"ingredientDescription: %@", ingredientDescription);
    //
    //    NSArray *ingredientPreparation = [ingredient objectForKey:@"preparation"];
    //    NSLog(@"ingredientPreparation: %@", ingredientPreparation);
    //    NSString *prep1 = [ingredientPreparation objectAtIndex:0];
    //    NSString *prep2 = [ingredientPreparation objectAtIndex:1];
    //    NSLog(@"prep1: %@", prep1);
    //    NSLog(@"prep2: %@", prep2);
    //
}

-(void)awakeFromNib {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
