//
//  loginViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/10/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "loginViewController.h"
#import "sproutsViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

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
}

//- (IBAction)loginButtonPushed:(UIButton *)sender {
//    sproutsViewController *mainView = [[sproutsViewController alloc] init];
//    [self.navigationController pushViewController:mainView animated:YES];
//}


- (IBAction)loginButtonPushed:(UIButton *)sender {
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"email"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
        } else {
            NSLog(@"User logged in through Facebook!");
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
