//
//  FeedViewCell.m
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/20/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "FeedViewCell.h"
#import "UIImage+ResizeAdditions.h"
#import "TTTTimeIntervalFormatter.h"

static TTTTimeIntervalFormatter *timeFormatter;

@implementation FeedViewCell
@synthesize sproutImage = _sproutImage;
@synthesize sproutTitle = _sproutTitle;
@synthesize sproutDescription = _sproutDescription;
@synthesize sproutedAt = _sproutedAt;

@synthesize sproutObject = _sproutObject;

@synthesize likeButton = _likeButton;
@synthesize commentButton = _commentButton;

@synthesize userName = _userName;
@synthesize userAvatar = _userAvatar;

@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if (!timeFormatter) {
            timeFormatter = [[TTTTimeIntervalFormatter alloc] init];
//            [timeFormatter setUsesAbbreviatedCalendarUnits:YES];
        }
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setSproutObject:(PFObject *)sproutObject {
    _sproutObject = sproutObject;
    
    [_commentButton addTarget:self action:@selector(didTapCommentOnSproutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_likeButton addTarget:self action:@selector(didTapLikeSproutButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    // User
    _userName.text = [[sproutObject objectForKey:@"user"] objectForKey:@"firstName"];
    
    // Set your placeholder image first
    _userAvatar.image = [UIImage imageNamed:@"Icon.png"];
    PFFile *avatarFile = [[sproutObject objectForKey:@"user"] objectForKey:@"profilePic"];
    [avatarFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        // Now that the data is fetched, update the cell's image property.
        _userAvatar.image = [[UIImage imageWithData:data] thumbnailImage:86.0f transparentBorder:0.0f cornerRadius:5.0f interpolationQuality:kCGInterpolationDefault];
    }];
    
    // Title
    _sproutTitle.text = [sproutObject objectForKey:@"title"];
    [_sproutTitle setFont:[UIFont fontWithName:@"MuseoSans-300" size:20.0]];
    [_sproutTitle setTextColor:[UIColor colorWithRed:(55/255.0) green:(140/255.0) blue:(96/255.0) alpha:1.0]];
    
    // Description
    _sproutDescription.text = [sproutObject objectForKey:(@"content")];
    [_sproutDescription setFont:[UIFont fontWithName:@"MuseoSans-300" size:14.0]];
    [_sproutDescription setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1.0]];
    
    // Timestamp
    NSString *timeString = [timeFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:sproutObject.createdAt];
    _sproutedAt.text = timeString;
    
    // Shadow
    //    CALayer *sublayer = [cell.sproutDescription superview].layer;
    //    sublayer.shadowOffset = CGSizeMake(0, 2);
    //    sublayer.shadowRadius = 2.0;
    //    sublayer.shadowColor = [UIColor grayColor].CGColor;
    //    sublayer.shadowOpacity = 0.5;
}

- (void)setLikeStatus:(BOOL)liked {
    [self.likeButton setSelected:liked];
    
//    if (liked) {
//        [self.likeButton setTitleEdgeInsets:UIEdgeInsetsMake(-1.0f, 0.0f, 0.0f, 0.0f)];
//        [[self.likeButton titleLabel] setShadowOffset:CGSizeMake(0.0f, -1.0f)];
//    } else {
//        [self.likeButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
//        [[self.likeButton titleLabel] setShadowOffset:CGSizeMake(0.0f, 1.0f)];
//    }
}

- (void)shouldEnableLikeButton:(BOOL)enable {
    if (enable) {
        [self.likeButton removeTarget:self action:@selector(didTapLikeSproutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.likeButton addTarget:self action:@selector(didTapLikeSproutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - ()

- (void)didTapUserButtonAction:(UIButton *)sender {
    if (delegate && [delegate respondsToSelector:@selector(feedViewCell:didTapUserButton:user:)]) {
        [delegate feedViewCell:self didTapUserButton:sender user:[self.sproutObject objectForKey:@"user"]];
    }
}

- (void)didTapLikeSproutButtonAction:(UIButton *)button {
    if (delegate && [delegate respondsToSelector:@selector(feedViewCell:didTapLikeSproutButton:sprout:)]) {
        [delegate feedViewCell:self didTapLikeSproutButton:button sprout:self.sproutObject];
    }
}

- (void)didTapCommentOnSproutButtonAction:(UIButton *)sender {
    if (delegate && [delegate respondsToSelector:@selector(feedViewCell:didTapCommentOnSproutButton:photo:)]) {
        [delegate feedViewCell:self didTapCommentOnSproutButton:sender sprout:self.sproutObject];
    }
}

@end
