//
//  IngredientInfoViewController.h
//  Sprouts
//
//  Created by Laura Wishingrad on 4/14/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface IngredientInfoViewController : UIViewController

//@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *descriptionView;
@property (weak, nonatomic) IBOutlet UIView *buyingView;
@property (weak, nonatomic) IBOutlet UITextView *seasonView;

@property (weak, nonatomic) IBOutlet UITextView *descriptionText;
@property (weak, nonatomic) IBOutlet UILabel *headerText;
@property (weak, nonatomic) IBOutlet UITextView *seasonText;
@property (weak, nonatomic) IBOutlet UILabel *seasonHeader;
@property (weak, nonatomic) IBOutlet UITextView *buyingText;
@property (weak, nonatomic) IBOutlet UILabel *buyingHeader;


//@property (weak, nonatomic) IBOutlet UIView *seasonView;

@end
