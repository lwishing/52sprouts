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

@synthesize childView = _childView;

- (void)viewDidLoad
{    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    // configure chld view controller view's frame
    self.childView.view.frame=CGRectMake( 0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height);
    
    // add child's view to view hierarchy
    [self.view addSubview:self.childView.view];
    
    
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
    // instantiate and assign the child view controller to a property to have direct reference to it in
    self.childView=[self.storyboard instantiateViewControllerWithIdentifier:@"ingredientInfo"];
    // configure your child view controller
    // add your child view controller to children array
    [self addChildViewController:self.childView];
    [self.childView didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
