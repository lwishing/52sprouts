//
//  profileViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/3/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "profileViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface profileViewController ()

@end

@implementation profileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Set background color to clear to make background image visible
    self.view.backgroundColor = [UIColor clearColor];
    
    // Access PFUser
    PFUser *currentUser = [PFUser currentUser];
    
    // Display name
    self.profileName.text = [NSString stringWithFormat:@"%@%@%@",[currentUser objectForKey:@"firstName"],@" ",[currentUser objectForKey:@"lastName"]];
    
    // Load profile image
    //    self.profileImage.image = [UIImage imageNamed:@"xxxxxx"]; // placeholder image
    self.profileImage.file = (PFFile *)[currentUser objectForKey:@"profilePic"]; // remote image
    [self.profileImage loadInBackground];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    // yay
}

@end
