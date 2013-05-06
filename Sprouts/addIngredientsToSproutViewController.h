//
//  addIngredientsToSproutViewController.h
//  Sprouts
//
//  Created by Laura Wishingrad on 4/16/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TITokenField.h"

@interface addIngredientsToSproutViewController : UIViewController <TITokenFieldDelegate, UITextViewDelegate> {
    
	TITokenFieldView * tokenFieldView;
	UITextView * messageView;
	
	CGFloat keyboardHeight;
}

@property (weak, nonatomic) IBOutlet UILabel *ingredientOfTheWeek;
@property (weak, nonatomic) IBOutlet UILabel *titleText;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet TITokenFieldView *tokenFieldView;

@end
