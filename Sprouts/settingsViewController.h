//
//  settingsViewController.h
//  Sprouts
//
//  Created by Laura Wishingrad on 4/14/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface settingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *profileName;

- (IBAction)logoutPressed:(id)sender;

@end
