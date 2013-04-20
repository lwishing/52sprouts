//
//  WelcomeViewController.m
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/16/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "WelcomeViewController.h"
#import <Parse/Parse.h>

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // If not logged in, present login view controller
    if (![PFUser currentUser]) {
        NSLog(@"User not logged in.");
        [self performSegueWithIdentifier:@"toLogin" sender:self];
        return;
    }
    // Present UI
    NSLog(@"User logged in already.");
    [self performSegueWithIdentifier:@"toMain" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
