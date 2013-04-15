//
//  sproutsActionViewController.h
//  Sprouts
//
//  Created by Laura Wishingrad on 4/3/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface sproutsActionViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *ingredientOfTheWeek;
@property (weak, nonatomic) IBOutlet UITextField *sproutTitle;
@property (weak, nonatomic) IBOutlet UITextField *sproutDescription;
@property (weak, nonatomic) IBOutlet UIImageView *sproutImage;

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)shareButtonPressed:(UIBarButtonItem *)sender;

- (IBAction)photoButtonPressed:(UIButton *)sender;

@end
