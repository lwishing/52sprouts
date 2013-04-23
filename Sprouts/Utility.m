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
