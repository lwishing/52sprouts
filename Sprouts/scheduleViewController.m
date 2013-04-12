//
//  scheduleViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/9/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "scheduleViewController.h"

@interface scheduleViewController ()

@end

@implementation scheduleViewController

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
    
    // Set background color to clear to make background image visible
    self.view.backgroundColor = [UIColor clearColor];
}
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
