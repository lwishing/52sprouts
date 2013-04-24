//
//  Utility.m
//  Sprouts
//
//  Created by Arthur Che on 4/17/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "Utility.h"

@implementation Utility

static Utility *_sharedInstance;

- (id) init
{
	if (self = [super init])
	{
		// custom initialization
        PFQuery *query = [PFQuery queryWithClassName:@"Week"];
        NSDate *date = [NSDate date];
        [query whereKey:@"startDate" lessThan:date];
        [query whereKey:@"endDate" greaterThan:date];
        [query includeKey:@"ingredient"];
        currentWeek = [query getFirstObject];
        currentIngredient = [currentWeek objectForKey:@"ingredient"];
	}
	return self;
}

+ (Utility *) sharedInstance
{
	if (!_sharedInstance)
	{
		_sharedInstance = [[Utility alloc] init];
	}
    
	return _sharedInstance;
}

- (PFObject *)getCurrentWeek {
    return currentWeek;
}

- (PFObject *)getCurrentIngredient {
    return currentIngredient;
}

@end

@implementation UIView (UIView_Expanded)

-(void)resizeToFitSubviews
{
    float w = 0;
    float h = 0;
    
    for (UIView *v in [self subviews]) {
        float fw = v.frame.origin.x + v.frame.size.width;
        float fh = v.frame.origin.y + v.frame.size.height;
        w = MAX(fw, w);
        h = MAX(fh, h);
    }
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, w, h)];
}

@end
