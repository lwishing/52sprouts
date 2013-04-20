//
//  FeedViewCell.h
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/20/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <Parse/Parse.h>

@interface FeedViewCell : PFTableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *sproutImage;
@property (weak, nonatomic) IBOutlet UILabel *sproutTitle;
@property (weak, nonatomic) IBOutlet UILabel *sproutDescription;
@property (weak, nonatomic) IBOutlet UILabel *sproutedAt;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet PFImageView *userAvatar;

@end
