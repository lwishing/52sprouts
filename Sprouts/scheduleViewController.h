//
//  scheduleViewController.h
//  Sprouts
//
//  Created by Laura Wishingrad on 4/9/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface scheduleViewController : UIViewController

@property (nonatomic, strong) NSString* dayOfWeek;

@property (strong, nonatomic) IBOutlet UILabel *dayOneLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayTwoLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayThreeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayFourLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayFiveLabel;
@property (strong, nonatomic) IBOutlet UILabel *daySixLabel;
@property (strong, nonatomic) IBOutlet UILabel *daySevenLabel;

@property (strong, nonatomic) IBOutlet UIButton *dayOne;
@property (strong, nonatomic) IBOutlet UIButton *dayTwo;
@property (strong, nonatomic) IBOutlet UIButton *dayThree;
@property (strong, nonatomic) IBOutlet UIButton *dayFour;
@property (strong, nonatomic) IBOutlet UIButton *dayFive;
@property (strong, nonatomic) IBOutlet UIButton *daySix;
@property (strong, nonatomic) IBOutlet UIButton *daySeven;

- (IBAction)dayOnePressed:(UIButton *)sender;
- (IBAction)dayTwoPressed:(UIButton *)sender;
- (IBAction)dayThreePressed:(UIButton *)sender;
- (IBAction)dayFourPressed:(UIButton *)sender;
- (IBAction)dayFivePressed:(UIButton *)sender;
- (IBAction)daySixPressed:(UIButton *)sender;
- (IBAction)daySevenPressed:(UIButton *)sender;

@end
