//
//  SproutsTabBarController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/3/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "SproutsTabBarController.h"
#import "sproutsActionViewController.h"
#import "Utility.h"

@interface SproutsTabBarController ()
@property (nonatomic,strong) UINavigationController *navController;
@end

@implementation SproutsTabBarController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navController = [[UINavigationController alloc] init];
        
    // Programmatically add Sprout button to UI
    UIButton *sproutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [UIImage imageNamed:@"sprout_button.png"];
//    UIImage *highlightImage = [UIImage imageNamed:@"sprout_pressed.png"];
    sproutButton.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [sproutButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [sproutButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
    if (heightDifference < 0)
        sproutButton.center = self.tabBar.center;
    else
    {
        CGPoint center = self.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        sproutButton.center = center;
    }
//    [sproutButton setTitle:@"Sprout" forState:UIControlStateNormal];
//    [sproutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sproutButton addTarget:self action:@selector(sproutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Gesture - Swipe up to Sprout
    UISwipeGestureRecognizer *swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(sproutButtonPressed:)];
    [swipeUpGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
    [swipeUpGestureRecognizer setNumberOfTouchesRequired:1];
    [sproutButton addGestureRecognizer:swipeUpGestureRecognizer];
    
    // get current week
    PFObject *week = [[[Utility alloc] init] getCurrentWeek];
    NSNumber *weekInt = [week objectForKey:@"week"];
    NSLog(@"week: %@", weekInt);
    
    // get current ingredient
    PFObject *ingredient = [week objectForKey:@"ingredient"];
    [ingredient fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        NSString *ingredientName = [ingredient objectForKey:@"name"];
        NSLog(@"ingredientName: %@", ingredientName);
    }];
    
    [self.view addSubview:sproutButton];
    
}

- (IBAction)sproutButtonPressed:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    sproutsActionViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"actionNavigation"];
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
