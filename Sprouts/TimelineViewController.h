//
//  TimelineViewController.h
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/18/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <Parse/Parse.h>
#import "FeedViewCell.h"

@interface TimelineViewController : PFQueryTableViewController <FeedViewCellDelegate>

@end
