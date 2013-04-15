//
//  sproutsFeedViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/11/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "sproutsFeedViewController.h"

@interface sproutsFeedViewController ()

@end

@implementation sproutsFeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    // get Week object
    PFQuery *queryWeek = [PFQuery queryWithClassName:@"Week"];
    PFObject *week = [queryWeek getObjectWithId:@"2VMFZOMUiY"];
    
    NSNumber *weekInt = [week objectForKey:@"week"];
    NSLog(@"week: %@", weekInt);
    
    NSDate *startDate = [week objectForKey:@"startDate"];
    NSLog(@"startDate: %@", startDate);
    
    NSDate *endDate = [week objectForKey:@"endDate"];
    NSLog(@"endDate: %@", endDate);
    
    // get ingredient object from the pointer in Week
    PFObject *ingredient = [week objectForKey:@"ingredient"];
    [ingredient fetchIfNeeded];
    
    NSString *ingredientId = ingredient.objectId;
    NSLog(@"ingredientId: %@", ingredientId);
    
    NSString *ingredientName = [ingredient objectForKey:@"name"];
    NSLog(@"ingredientName: %@", ingredientName);
    
    NSString *ingredientDescription = [ingredient objectForKey:@"description"];
    NSLog(@"ingredientDescription: %@", ingredientDescription);
    
    NSArray *ingredientPreparation = [ingredient objectForKey:@"preparation"];
    NSLog(@"ingredientPreparation: %@", ingredientPreparation);
    NSString *prep1 = [ingredientPreparation objectAtIndex:0];
    NSString *prep2 = [ingredientPreparation objectAtIndex:1];
    NSLog(@"prep1: %@", prep1);
    NSLog(@"prep2: %@", prep2);
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
