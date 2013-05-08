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
#import <QuartzCore/QuartzCore.h>
#import "Utility.h"

@implementation FeedViewCell
@synthesize sproutImage = _sproutImage;
@synthesize sproutTitle = _sproutTitle;
@synthesize sproutDescription = _sproutDescription;
@synthesize sproutedAt = _sproutedAt;
@synthesize sproutBody = _sproutBody;
@synthesize sproutIngredients = _sproutIngredients;

@synthesize sproutObject = _sproutObject;

@synthesize likeButton = _likeButton;
@synthesize commentButton = _commentButton;

@synthesize userName = _userName;
@synthesize userAvatar = _userAvatar;

@synthesize height;
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

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
    Utility *util = [Utility sharedInstance];
    
    _sproutObject = sproutObject;
    height = 0.0;
    
//    [_commentButton addTarget:self action:@selector(didTapCommentOnSproutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_likeButton addTarget:self action:@selector(didTapLikeSproutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _likeButton.titleLabel.font = [util smallFont];

    //Image
    PFFile *imageFile = [sproutObject objectForKey:@"photo"];    
    if (imageFile != nil) {
        // Set your placeholder image first
        _sproutImage.image = [UIImage imageNamed:@"loading_photo.png"];
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            // Now that the data is fetched, update the cell's image property.
            _sproutImage.image = [UIImage imageWithData:data];
//            _sproutImage.layer.shadowColor = [UIColor grayColor].CGColor;
//            _sproutImage.layer.shadowOffset = CGSizeMake(0, 2);
//            _sproutImage.layer.shadowOpacity = 0.5;
//            _sproutImage.layer.shadowRadius = 2.0;
            _sproutImage.layer.masksToBounds = YES;
//            _sproutImage.clipsToBounds = NO;
//            [_sproutImage.layer setShadowPath:[[UIBezierPath bezierPathWithRect:_sproutImage.bounds] CGPath]];
        }];
        
        height += _sproutImage.image.size.height;
    }
    
    // User
    NSString *name = [NSString stringWithFormat:@"%@ %@.",
                      [[sproutObject objectForKey:@"user"] objectForKey:@"firstName"],
                      [[[sproutObject objectForKey:@"user"] objectForKey:@"lastName"] substringToIndex:1]];
    _userName.text = name;
    _userName.font = [util bodyFont];
    _userName.textColor = [util darkGreyColor];
    
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

    CGFloat descriptionLabelHeight = [self sizeOfLabel:_sproutDescription withText:_sproutDescription.text].height;
    CGFloat titleLabelHeight = [self sizeOfLabel:_sproutTitle withText:_sproutTitle.text].height;
    
    _sproutDescription.numberOfLines = 0;
    _sproutDescription.frame = CGRectMake(_sproutDescription.frame.origin.x, _sproutDescription.frame.origin.y, 280.0, descriptionLabelHeight);
    
    height += titleLabelHeight + descriptionLabelHeight + 80.0;
    
    // Timestamp
    TTTTimeIntervalFormatter *timeFormatter = [[TTTTimeIntervalFormatter alloc] init];
    NSString *timeString = [timeFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:_sproutObject.createdAt];
    _sproutedAt.font = [util smallFont];
    _sproutedAt.textColor = [util greyColor];
    _sproutedAt.text = timeString;
    
    // Ingredients
    NSArray *ingredientArray = [sproutObject objectForKey:(@"ingredients")];
    if (ingredientArray != nil && [ingredientArray count] != 0) {
        [_sproutIngredients setHidden:NO];
        [_sproutIngredients setAutomaticResize:YES];
        [_sproutIngredients setScrollsToTop:NO];
        [_sproutIngredients setTags:ingredientArray];
        height += [_sproutIngredients fittedSize].height + 15;
    } else {
        [_sproutIngredients setHidden:YES];
        // Add bottom padding
        height += 10;
    }
    
    // Rounded Corners + Drop Shadow
//    CALayer *sublayer = _sproutBody.layer;
//    sublayer.cornerRadius = 3.0f;
//    sublayer.masksToBounds = YES;
//    sublayer.shouldRasterize = YES;
//    sublayer.rasterizationScale = [[UIScreen mainScreen] scale];
    
//    sublayer.shadowOffset = CGSizeMake(0, 2);
//    sublayer.shadowRadius = 2.0;
//    sublayer.shadowColor = [UIColor grayColor].CGColor;
//    sublayer.shadowOpacity = 0.5;
//    CGRect shadowFrame = _sproutBody.layer.bounds;
//    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
//    sublayer.shadowPath = shadowPath;
    
}

- (CGSize)sizeOfLabel:(UILabel *)label withText:(NSString *)text {
    return [text sizeWithFont:label.font constrainedToSize:CGSizeMake(280.0, 5000.0) lineBreakMode:NSLineBreakByWordWrapping];
}

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
	[self.layer setShadowPath:[[UIBezierPath bezierPathWithRect:self.bounds] CGPath]];
}

#pragma mark Event Handling
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
