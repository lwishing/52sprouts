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
@property (weak, nonatomic) IBOutlet UILabel *headerText;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;




@end
