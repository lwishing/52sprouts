//
//  profileViewController.h
//  Sprouts
//
//  Created by Laura Wishingrad on 4/3/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface profileViewController : UIViewController

@property (nonatomic, strong) PFQueryTableViewController *sproutsView;
@property (nonatomic, strong) PFQueryTableViewController *likesView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;


@end
