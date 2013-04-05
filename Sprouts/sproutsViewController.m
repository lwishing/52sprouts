//
//  sproutsViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/3/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "sproutsViewController.h"
#import "sproutsActionViewController.h"

@interface sproutsViewController ()

@end

// This is a comment

@implementation sproutsViewController

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
    
    // Programmatically add Sprout button to UI
    UIButton* sproutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sproutButton.frame = CGRectMake(0.0, 0.0, 80.0, 80.0);
    sproutButton.center = self.tabBar.center;
    [sproutButton setTitle:@"Sprout" forState:UIControlStateNormal];
    [sproutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sproutButton addTarget:self action:@selector(sproutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:sproutButton];
    
}

- (IBAction)sproutButtonPressed:(UIButton *)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    sproutsActionViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"action"];
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
