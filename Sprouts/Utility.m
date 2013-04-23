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

- (PFObject *)getCurrentIngredient:(PFObject *)week {
    NSString *ingredientID = [week objectForKey:@"ingredient"];
    PFQuery *ingredientQuery = [PFQuery queryWithClassName:@"Ingredient"];
    [ingredientQuery whereKey:@"objectId" equalTo:ingredientID];
    [ingredientQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    PFObject *ingredientObject = [ingredientQuery getFirstObject];
    return ingredientObject;
}

@end
