//
//  FeedViewCell.h
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/20/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <Parse/Parse.h>

@protocol FeedViewCellDelegate;

@interface FeedViewCell : PFTableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *sproutImage;
@property (weak, nonatomic) IBOutlet UILabel *sproutTitle;
@property (weak, nonatomic) IBOutlet UILabel *sproutDescription;
@property (weak, nonatomic) IBOutlet UILabel *sproutedAt;

@property (weak, nonatomic) PFObject *sproutObject;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet PFImageView *userAvatar;

@property (weak, nonatomic) id <FeedViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *sproutBody;
@property CGFloat height;

/*!
 Configures the Like Button to match the given like status.
 @param liked a BOOL indicating if the associated photo is liked by the user
 */
- (void)setLikeStatus:(BOOL)liked;

/*!
 Enable the like button to start receiving actions.
 @param enable a BOOL indicating if the like button should be enabled.
 */
- (void)shouldEnableLikeButton:(BOOL)enable;

@end

/*!
 The protocol defines methods a delegate of a FeedViewCell should implement.
 All methods of the protocol are optional.
 */
@protocol FeedViewCellDelegate <NSObject>
@optional

/*!
 Sent to the delegate when the user button is tapped
 @param user the PFUser associated with this button
 */
- (void)feedViewCell:(FeedViewCell *)feedViewCell didTapUserButton:(UIButton *)button user:(PFUser *)user;

/*!
 Sent to the delegate when the like photo button is tapped
 @param photo the PFObject for the photo that is being liked or disliked
 */
- (void)feedViewCell:(FeedViewCell *)feedViewCell didTapLikeSproutButton:(UIButton *)button sprout:(PFObject *)sprout;

/*!
 Sent to the delegate when the comment on photo button is tapped
 @param photo the PFObject for the photo that will be commented on
 */
- (void)feedViewCell:(FeedViewCell *)feedViewCell didTapCommentOnSproutButton:(UIButton *)button sprout:(PFObject *)sprout;

@end