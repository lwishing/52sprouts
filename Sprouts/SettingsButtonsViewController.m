//
//  SettingsButtonsViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/26/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "SettingsButtonsViewController.h"
#import "WebViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SettingsButtonsViewController ()

@end

@implementation SettingsButtonsViewController
@synthesize privacyButton, termsButton, websiteButton, twitterButton, logoutButton, termsLabel, contactLabel, sproutImage;

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
    privacyButton.titleLabel.font = [UIFont fontWithName:@"MuseoSans-500" size:17.0];
    termsButton.titleLabel.font = [UIFont fontWithName:@"MuseoSans-500" size:17.0];
    websiteButton.titleLabel.font = [UIFont fontWithName:@"MuseoSans-500" size:17.0];
    twitterButton.titleLabel.font = [UIFont fontWithName:@"MuseoSans-500" size:17.0];
    logoutButton.titleLabel.font = [UIFont fontWithName:@"MuseoSans-500" size:17.0];
    
    logoutButton.layer.borderColor = [UIColor grayColor].CGColor;
    logoutButton.layer.borderWidth = 0.5f;
    logoutButton.layer.cornerRadius = 8.0;
    
    
    
    privacyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    termsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    websiteButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    twitterButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [termsLabel setFont:[UIFont fontWithName:@"MuseoSans-500" size:14.0]];
    [contactLabel setFont:[UIFont fontWithName:@"MuseoSans-500" size:14.0]];
    
    sproutImage.hidden = YES;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        sproutImage.hidden = NO;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)privacyPressed:(id)sender {
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.theURL = [NSURL URLWithString:@"http://52sprouts.com/privacy"];
    webViewController.theTitle = @"Privacy Policy";
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)termsPressed:(id)sender {
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.theURL = [NSURL URLWithString:@"http://52sprouts.com/terms"];
    webViewController.theTitle = @"Terms of Service";
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)websitePressed:(id)sender {
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.theURL = [NSURL URLWithString:@"http://52sprouts.com"];
    webViewController.theTitle = @"52sprouts.com";
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)twitterPressed:(id)sender {
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.theURL = [NSURL URLWithString:@"https://twitter.com/52sprouts"];
    webViewController.theTitle = @"@52sprouts";
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)logoutPressed:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"logout" sender:self];
}
@end
