//
//  Utility.m
//  Sprouts
//
//  Created by Arthur Che on 4/17/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "Utility.h"

@implementation Utility

- (PFObject *)getCurrentWeek {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Week"];
    NSDate *date = [NSDate date];
    [query whereKey:@"startDate" lessThan:date];
    [query whereKey:@"endDate" greaterThan:date];
    
    PFObject *week = [query getFirstObject];
    
    return week;
}

@end
