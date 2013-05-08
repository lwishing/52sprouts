//
//  ProfileTableViewController.h
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/18/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "TimelineViewController.h"

@interface ProfileTableViewController : TimelineViewController

@property (strong, nonatomic) IBOutlet UILabel *profileName;
@property (strong, nonatomic) IBOutlet PFImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *profileBanner;
@property (weak, nonatomic) IBOutlet UIImageView *header;


@end
