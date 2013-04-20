//
//  FeedViewCell.m
//  Sprouts
//
//  Created by Gilbert Hernandez on 4/20/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "FeedViewCell.h"

@implementation FeedViewCell
@synthesize sproutImage = _sproutImage;
@synthesize sproutTitle = _sproutTitle;
@synthesize sproutDescription = _sproutDescription;
@synthesize sproutedAt = _sproutedAt;

@synthesize userName = _userName;
@synthesize userAvatar = _userAvatar;


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

@end
