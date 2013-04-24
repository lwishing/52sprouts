//
//  Utility.h
//  Sprouts
//
//  Created by Arthur Che on 4/17/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface Utility : NSObject {
    PFObject *currentWeek;
    PFObject *currentIngredient;
}

+ (Utility *) sharedInstance;

- (PFObject *)getCurrentWeek;
- (PFObject *)getCurrentIngredient;

@end

@interface UIView (UIView_Expanded)

-(void)resizeToFitSubviews;

@end
