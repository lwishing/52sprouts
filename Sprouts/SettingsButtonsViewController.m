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
@synthesize privacyButton, termsButton, websiteButton, twitterButton, logoutButton, termsLabel, contactLabel, sproutImage, scrollView, acknowledgementsButton;

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
    acknowledgementsButton.titleLabel.font = [UIFont fontWithName:@"MuseoSans-500" size:17.0];
    
    logoutButton.layer.borderColor = [UIColor grayColor].CGColor;
    logoutButton.layer.borderWidth = 0.5f;
    logoutButton.layer.cornerRadius = 8.0;
    
    UIImage *backButtonHomeImage = [[UIImage imageNamed:@"back_arrow.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 4)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonHomeImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    privacyButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    termsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    websiteButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    twitterButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    acknowledgementsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    [termsLabel setFont:[UIFont fontWithName:@"MuseoSans-500" size:14.0]];
    [contactLabel setFont:[UIFont fontWithName:@"MuseoSans-500" size:14.0]];
    
//    sproutImage.hidden = YES;
//    
//    if ([[UIScreen mainScreen] bounds].size.height == 568) {
//        sproutImage.hidden = NO;
//    }
    
    NSArray *buttons = [[NSArray alloc] initWithObjects: privacyButton, termsButton, websiteButton, twitterButton, acknowledgementsButton, nil];
    
    for (UIButton *button in buttons) {
        
        CALayer *shadowLayer = button.layer;
        
        shadowLayer.shadowColor = [UIColor grayColor].CGColor;
        shadowLayer.shadowOffset = CGSizeMake(0, 0);
        shadowLayer.shadowRadius = 1.0;
        shadowLayer.shadowOpacity = .5;
        shadowLayer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:button.bounds cornerRadius:5].CGPath; // make sure you set that for better performance
        
        CALayer *sublayer = button.layer;
            
        sublayer.cornerRadius = 3;
        sublayer.masksToBounds = YES;
        //button.clipsToBounds = YES;
    

    }
    
    scrollView.contentSize=CGSizeMake(320, 455);
    scrollView.contentInset= UIEdgeInsetsMake(0.0,0.0, 30.0,0.0);

    
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
    //[self.navigationController pushViewController:webViewController animated:YES];
    [self presentViewController:webViewController animated:YES completion:nil];
}

- (IBAction)termsPressed:(id)sender {
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.theURL = [NSURL URLWithString:@"http://52sprouts.com/terms"];
    webViewController.theTitle = @"Terms of Service";
    [self presentViewController:webViewController animated:YES completion:nil];
}

- (IBAction)websitePressed:(id)sender {
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.theURL = [NSURL URLWithString:@"http://52sprouts.com"];
    webViewController.theTitle = @"52sprouts.com";
    [self presentViewController:webViewController animated:YES completion:nil];
}

- (IBAction)twitterPressed:(id)sender {
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.theURL = [NSURL URLWithString:@"https://twitter.com/52sprouts"];
    webViewController.theTitle = @"@52sprouts";
    [self presentViewController:webViewController animated:YES completion:nil];
}

- (IBAction)feedbackPressed:(id)sender {
    NSString *url = @"mailto:feedback@52sprouts.com?&subject=Feedback";
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
}

- (IBAction)acknowledgementsPressed:(id)sender {
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WebViewController"];
    webViewController.theURL = [NSURL URLWithString:@"http://52sprouts.com/acknowledgements"];
    webViewController.theTitle = @"Acknowledgements";
    [self presentViewController:webViewController animated:YES completion:nil];
}


- (IBAction)logoutPressed:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"logout" sender:self];
}
@end
