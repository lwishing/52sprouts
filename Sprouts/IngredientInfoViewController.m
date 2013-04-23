//
//  IngredientInfoViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/14/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "IngredientInfoViewController.h"
#import "Utility.h"

@interface IngredientInfoViewController ()

@end

@implementation IngredientInfoViewController

@synthesize headerView, descriptionView, seasonView, buyingView, storingView;
@synthesize headerText, descriptionText, seasonText, buyingText, storingText;;
@synthesize seasonHeader, buyingHeader, storingHeader;

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
    
    //set the fonts
    [headerText setFont:[UIFont fontWithName:@"MuseoSans-500" size:14.0]];
    [descriptionText setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    [seasonHeader setFont:[UIFont fontWithName:@"MuseoSans-300" size:20.0]];
    [seasonText setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    [buyingHeader setFont:[UIFont fontWithName:@"MuseoSans-300" size:20.0]];
    [buyingText setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    [storingHeader setFont:[UIFont fontWithName:@"MuseoSans-300" size:20.0]];
    [storingText setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    
    [[headerView superview] bringSubviewToFront:headerView];
    
    //resizeable background image
    //UIImage *backgroundImage = [[UIImage imageNamed:@"contentBackground"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 0, 10, 0)];
    
    PFObject *ingredient = [[Utility sharedInstance] getCurrentIngredient];
    
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
    
      NSLog(@"My view's height is: %f", seasonText.contentSize.height);
    /*CGRect seasonFrame = seasonText.frame;
     seasonFrame.size.height = seasonText.contentSize.height;
     seasonText.frame = seasonFrame;*/
    
    //set when buying text
    [buyingText setText:[ingredient objectForKey:@"whenBuying"]];
    
    /*CGRect buyingFrame = buyingText.frame;
     buyingFrame.size.height = buyingText.contentSize.height;
     buyingText.frame = buyingFrame;*/
    
    //set storing text
    [storingText setText:[ingredient objectForKey:@"storing"]];
    
    /*CGRect storingFrame = storingText.frame;
     storingFrame.size.height = storingText.contentSize.height;
     storingText.frame = storingFrame;*/
    
    //set title bar's title to ingredient
    [self setTitle:[ingredient objectForKey:@"name"]];
    
    
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
