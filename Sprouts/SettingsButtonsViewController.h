//
//  SettingsButtonsViewController.h
//  Sprouts
//
//  Created by Laura Wishingrad on 4/26/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SettingsButtonsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *privacyButton;
@property (weak, nonatomic) IBOutlet UIButton *termsButton;
@property (weak, nonatomic) IBOutlet UIButton *websiteButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UILabel *termsLabel;
@property (weak, nonatomic) IBOutlet UILabel *contactLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sproutImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *acknowledgementsButton;

- (IBAction)privacyPressed:(id)sender;
- (IBAction)termsPressed:(id)sender;
- (IBAction)websitePressed:(id)sender;
- (IBAction)twitterPressed:(id)sender;
- (IBAction)feedbackPressed:(id)sender;
- (IBAction)acknowledgementsPressed:(id)sender;
- (IBAction)logoutPressed:(id)sender;

@end