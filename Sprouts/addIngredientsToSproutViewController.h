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

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;

@end
