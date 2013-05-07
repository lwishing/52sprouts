//
//  sproutsActionViewController.h
//  Sprouts
//
//  Created by Laura Wishingrad on 4/3/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "SSTextView.h"
#import "DWTagList.h"

@interface sproutsActionViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *sproutScrollView;
@property (weak, nonatomic) IBOutlet UILabel *ingredientOfTheWeek;
@property (weak, nonatomic) IBOutlet UITextField *sproutTitle;
@property (weak, nonatomic) IBOutlet UILabel *shareText;
@property (weak, nonatomic) IBOutlet SSTextView *sproutDescription;
@property (weak, nonatomic) IBOutlet UIImageView *sproutImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *characterCountTitle;
@property (weak, nonatomic) IBOutlet UILabel *characterCountDescription;
@property (weak, nonatomic) IBOutlet UIView *sproutView;
@property (weak, nonatomic) IBOutlet UIButton *addIngredients;
@property (weak, nonatomic) NSArray *ingredientArray;
@property (strong, nonatomic) IBOutlet DWTagList *ingredientList;

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)shareButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)photoButtonPressed:(UIButton *)sender;

@end
