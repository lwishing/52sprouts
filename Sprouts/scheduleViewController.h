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

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSString* dayOfWeek;
@property (nonatomic, strong) NSString* todayDate;
@property (nonatomic, strong) NSDate* dayOneActual;
@property (nonatomic, strong) NSDate* dayTwoActual;
@property (nonatomic, strong) NSDate* dayThreeActual;
@property (nonatomic, strong) NSDate* dayFourActual;
@property (nonatomic, strong) NSDate* dayFiveActual;
@property (nonatomic, strong) NSDate* daySixActual;
@property (nonatomic, strong) NSDate* daySevenActual;


@property (nonatomic, strong) PFObject* week;
@property (nonatomic, strong) PFObject* ingredient;
@property (nonatomic, strong) PFUser* currentUser;

@property (strong, nonatomic) IBOutlet UILabel *scheduleMessage;

@property (strong, nonatomic) IBOutlet UILabel *dayOneLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayTwoLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayThreeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayFourLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayFiveLabel;
@property (strong, nonatomic) IBOutlet UILabel *daySixLabel;
@property (strong, nonatomic) IBOutlet UILabel *daySevenLabel;

@property (strong, nonatomic) IBOutlet UILabel *dayOneDate;
@property (strong, nonatomic) IBOutlet UILabel *dayTwoDate;
@property (strong, nonatomic) IBOutlet UILabel *dayThreeDate;
@property (strong, nonatomic) IBOutlet UILabel *dayFourDate;
@property (strong, nonatomic) IBOutlet UILabel *dayFiveDate;
@property (strong, nonatomic) IBOutlet UILabel *daySixDate;
@property (strong, nonatomic) IBOutlet UILabel *daySevenDate;


@property (strong, nonatomic) IBOutlet UIButton *dayOne;
@property (strong, nonatomic) IBOutlet UIButton *dayTwo;
@property (strong, nonatomic) IBOutlet UIButton *dayThree;
@property (strong, nonatomic) IBOutlet UIButton *dayFour;
@property (strong, nonatomic) IBOutlet UIButton *dayFive;
@property (strong, nonatomic) IBOutlet UIButton *daySix;
@property (strong, nonatomic) IBOutlet UIButton *daySeven;

- (IBAction)dayPressed:(UIButton *)sender;

- (void)scheduleNotification: (NSDate *)input;


@end
