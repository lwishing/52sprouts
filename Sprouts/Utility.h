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
    
    UIFont *bannerFont;
    UIFont *mediumFont;
    
    UIFont *headerFont;
    UIFont *bodyFont;
    UIFont *smallFont;
    
    UIColor *greenColor;
    UIColor *greyColor;
    UIColor *darkGreyColor;
    
}

+ (Utility *) sharedInstance;

- (PFObject *)getCurrentWeek;
- (PFObject *)getCurrentIngredient;

- (UIFont *)bannerFont;
- (UIFont *)mediumFont;
- (UIFont *)smallFont;
- (UIFont *)headerFont;
- (UIFont *)bodyFont;

- (UIColor *)greenColor;
- (UIColor *)greyColor;
- (UIColor *)darkGreyColor;

+ (PFQuery *) queryForActivitiesOnSprout:(PFObject *)photo cachePolicy:(PFCachePolicy)cachePolicy;

+ (void)likeSproutInBackground:(id)photo block:(void (^)(BOOL succeeded, NSError *error))completionBlock;
+ (void)unlikeSproutInBackground:(id)photo block:(void (^)(BOOL succeeded, NSError *error))completionBlock;

@end

@interface UIView (UIView_Expanded)

-(void)resizeToFitSubviews;

@end
