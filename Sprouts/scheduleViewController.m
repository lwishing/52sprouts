//
//  scheduleViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/9/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "scheduleViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Utility.h"


@interface scheduleViewController ()

@end

@implementation scheduleViewController

@synthesize scrollView, tipsHeader, tipsBanner, pickDayHeader, scheduleMessage;
@synthesize dayOfWeek, todayDate;
@synthesize week, ingredient;
@synthesize dayOneActual, dayTwoActual, dayThreeActual, dayFourActual, dayFiveActual, daySixActual, daySevenActual;
@synthesize dayOne, dayTwo, dayThree, dayFour, dayFive, daySix, daySeven;
@synthesize currentUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //setting fonts
    [pickDayHeader setFont:[[Utility sharedInstance] mediumFont]];
    [pickDayHeader setTextColor:[[Utility sharedInstance] darkGreyColor]];
    [scheduleMessage setFont:[[Utility sharedInstance] mediumFont]];
    [scheduleMessage setTextColor:[[Utility sharedInstance] darkGreyColor]];
    
    //back button
    UIImage *backButtonHomeImage = [[UIImage imageNamed:@"back_arrow.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 4)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonHomeImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    // figure out current day of the week  
    NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
    [weekday setDateFormat:@"EEEE"];
    dayOfWeek = [weekday stringFromDate:[NSDate date]];
    
    NSDateFormatter *buttonDate = [[NSDateFormatter alloc] init];
    [buttonDate setDateFormat:@"M/d"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMM d, ''yy, h:mm a"];
    
    // get current week
    week = [[Utility sharedInstance] getCurrentWeek];
    ingredient = [[Utility sharedInstance] getCurrentIngredient];
    currentUser = [PFUser currentUser];
    
    // get startDate of the week, and normalize it to Monday 12am for local time zone
    NSDate *startDate = [week objectForKey:@"startDate"];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: startDate];
    startDate = [gregorian dateFromComponents:components];
    NSLog(@"startDate: %@", [dateFormatter stringFromDate:startDate]);

    // create NSDate objects for each day of week, timed at 11am
    dayOneActual = [startDate dateByAddingTimeInterval:60*60*11];
    NSLog(@"Day 1: %@", [dateFormatter stringFromDate:dayOneActual]);
    dayTwoActual = [dayOneActual dateByAddingTimeInterval:60*60*24*1];
    NSLog(@"Day 2: %@", [dateFormatter stringFromDate:dayTwoActual]);
    dayThreeActual = [dayOneActual dateByAddingTimeInterval:60*60*24*2];
    NSLog(@"Day 3: %@", [dateFormatter stringFromDate:dayThreeActual]);
    dayFourActual = [dayOneActual dateByAddingTimeInterval:60*60*24*3];
    NSLog(@"Day 4: %@", [dateFormatter stringFromDate:dayFourActual]);
    dayFiveActual = [dayOneActual dateByAddingTimeInterval:60*60*24*4];
    NSLog(@"Day 5: %@", [dateFormatter stringFromDate:dayFiveActual]);
    daySixActual = [dayOneActual dateByAddingTimeInterval:60*60*24*5];
    NSLog(@"Day 6: %@", [dateFormatter stringFromDate:daySixActual]);
    daySevenActual = [dayOneActual dateByAddingTimeInterval:60*60*24*6];
    NSLog(@"Day 7: %@", [dateFormatter stringFromDate:daySevenActual]);
    
    dayOne.tag = 1;
    dayTwo.tag = 2;
    dayThree.tag = 3;
    dayFour.tag = 4;
    dayFive.tag = 5;
    daySix.tag = 6;
    daySeven.tag = 7;
    
    // show date string below each button
    self.dayOneDate.text = [buttonDate stringFromDate:dayOneActual];
    self.dayTwoDate.text =  [buttonDate stringFromDate:dayTwoActual];
    self.dayThreeDate.text = [buttonDate stringFromDate:dayThreeActual];
    self.dayFourDate.text = [buttonDate stringFromDate:dayFourActual];
    self.dayFiveDate.text = [buttonDate stringFromDate:dayFiveActual];
    self.daySixDate.text = [buttonDate stringFromDate:daySixActual];
    self.daySevenDate.text = [buttonDate stringFromDate:daySevenActual];

    // check user's scheduledDay, reset if from past week
    NSDate *scheduled = [[PFUser currentUser] objectForKey:@"scheduledDay"];
    NSLog(@"scheduledDay: %@", [dateFormatter stringFromDate:scheduled]);
    if ([[weekday stringFromDate:scheduled] isEqualToString:@"Thursday"]) {
        [dayOne setSelected:YES];
        self.scheduleMessage.text = @"You're set to cook on Thursday.";
    } else if ([[weekday stringFromDate:scheduled] isEqualToString:@"Friday"]) {
        [dayTwo setSelected:YES];
        self.scheduleMessage.text = @"You're set to cook on Friday.";
    } else if ([[weekday stringFromDate:scheduled] isEqualToString:@"Saturday"]) {
        [dayThree setSelected:YES];
        self.scheduleMessage.text = @"You're set to cook on Saturday.";
    } else if ([[weekday stringFromDate:scheduled] isEqualToString:@"Sunday"]) {
        [dayFour setSelected:YES];
        self.scheduleMessage.text = @"You're set to cook on Sunday.";
    } else if ([[weekday stringFromDate:scheduled] isEqualToString:@"Monday"]) {
        [dayFive setSelected:YES];
        self.scheduleMessage.text = @"You're set to cook on Monday.";
    } else if ([[weekday stringFromDate:scheduled] isEqualToString:@"Tuesday"]) {
        [daySix setSelected:YES];
        self.scheduleMessage.text = @"You're set to cook on Tuesday.";
    } else if ([[weekday stringFromDate:scheduled] isEqualToString:@"Wednesday"]) {
        [daySeven setSelected:YES];
        self.scheduleMessage.text = @"You're set to cook on Wednesday.";
    } else {
        scrollView.hidden = YES;
        tipsHeader.hidden = YES;
        tipsBanner.hidden = YES;
    }
    
    
//    dayOfWeek = @"Thursday";
    
    // disable buttons if day has passed
    if ([dayOfWeek isEqualToString:@"Thursday"]) {
    } else if ([dayOfWeek isEqualToString:@"Friday"]) {
        [self.dayOne setEnabled:NO];
    } else if ([dayOfWeek isEqualToString:@"Saturday"]) {
        [self.dayOne setEnabled:NO];
        [self.dayTwo setEnabled:NO];
    } else if ([dayOfWeek isEqualToString:@"Sunday"]) {
        [self.dayOne setEnabled:NO];
        [self.dayTwo setEnabled:NO];
        [self.dayThree setEnabled:NO];
    } else if ([dayOfWeek isEqualToString:@"Monday"]) {
        [self.dayOne setEnabled:NO];
        [self.dayTwo setEnabled:NO];
        [self.dayThree setEnabled:NO];
        [self.dayFour setEnabled:NO];
    } else if ([dayOfWeek isEqualToString:@"Tuesday"]) {
        [self.dayOne setEnabled:NO];
        [self.dayTwo setEnabled:NO];
        [self.dayThree setEnabled:NO];
        [self.dayFour setEnabled:NO];
        [self.dayFive setEnabled:NO];
    } else if ([dayOfWeek isEqualToString:@"Wednesday"]) {
        [self.dayOne setEnabled:NO];
        [self.dayTwo setEnabled:NO];
        [self.dayThree setEnabled:NO];
        [self.dayFour setEnabled:NO];
        [self.dayFive setEnabled:NO];
        [self.daySix setEnabled:NO];
    }
    
    
    int padding = 15;
    int x = 10;
    int y = 10;
    int width = 300;
    int headerHeight = 24;
    int inset = 8;
    
    //BUYING
    
    //container uiview
    UIView *buyingView = [[UIView alloc] initWithFrame:CGRectMake(x, y + padding, width, 0)];
    [buyingView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *buyingHeader = [[UILabel alloc] initWithFrame:CGRectMake(inset, inset, 280, headerHeight)];
    buyingHeader.text = @"When Buying";
    [buyingHeader setFont:[[Utility sharedInstance] headerFont]];
    [buyingHeader setTextColor:[[Utility sharedInstance] greenColor]];
    
    //when buying text
    UITextView *buyingText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    buyingText.text = [ingredient objectForKey:@"whenBuying"];
    [buyingText setFont:[[Utility sharedInstance] bodyFont]];
    [buyingText setTextColor:[[Utility sharedInstance] greyColor]];
    [buyingText setUserInteractionEnabled:NO];
    [buyingText setBackgroundColor:[UIColor clearColor]];
    
    [buyingView addSubview:buyingHeader];
    [buyingView addSubview:buyingText];
    
    //resize textview to fit the content
    CGRect buyingFrame = buyingText.frame;
    buyingFrame.size.height = buyingText.contentSize.height;
    buyingText.frame = buyingFrame;
    
    //add container view to scrollview
    [scrollView addSubview: buyingView];
    
    //resize containerview to fit everything
    [buyingView resizeToFitSubviews];
    
    //adjust y to new start point
    y += buyingView.frame.size.height + padding;
    
    //STORING
    
    //container uiview
    UIView *storingView = [[UIView alloc] initWithFrame:CGRectMake(x, y + padding, width, 0)];
    [storingView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *storingHeader = [[UILabel alloc] initWithFrame:CGRectMake(inset, inset, 280, headerHeight)];
    storingHeader.text = @"Storing";
    [storingHeader setFont:[[Utility sharedInstance] headerFont]];
    [storingHeader setTextColor:[[Utility sharedInstance] greenColor]];
    
    //when buying text
    UITextView *storingText = [[UITextView alloc] initWithFrame:CGRectMake(0, inset + headerHeight, width, 0)];
    storingText.text = [ingredient objectForKey:@"storing"];
    [storingText setFont:[[Utility sharedInstance] bodyFont]];
    [storingText setTextColor:[[Utility sharedInstance] greyColor]];
    [storingText setUserInteractionEnabled:NO];
    [storingText setBackgroundColor:[UIColor clearColor]];
    
    [storingView addSubview:storingHeader];
    [storingView addSubview:storingText];
    
    //resize textview to fit the content
    CGRect storingFrame = storingText.frame;
    storingFrame.size.height = storingText.contentSize.height;
    storingText.frame = storingFrame;
    
    //add container view to scrollview
    [scrollView addSubview: storingView];
    
    //resize containerview to fit everything
    [storingView resizeToFitSubviews];
    
    //adjust y to new start point
    y += storingView.frame.size.height + padding;
    
    scrollView.contentSize=CGSizeMake(320, y);
    scrollView.contentInset= UIEdgeInsetsMake(0.0,0.0, 30.0,0.0);
    
    // shadow experiment
    for (UIView *subview in [scrollView subviews]) {
        
        if(![subview isKindOfClass:[UIImageView class]]){
            
            NSLog(@"view: %@", subview.description);
            
            CALayer *sublayer = subview.layer;
            
            sublayer.cornerRadius = 3;
            
            sublayer.shadowColor = [UIColor grayColor].CGColor;
            sublayer.shadowOffset = CGSizeMake(0, 0);
            sublayer.shadowRadius = 1.0;
            sublayer.shadowOpacity = .5;
            sublayer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:subview.bounds cornerRadius:5].CGPath; // make sure you set that for better performance
        }
    }

    
    
}
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scheduleNotification: (NSDate *)inputDate{
    
    // reset notifications each time method is called
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // if reminder time has passed, don't sent a notification
    if ([inputDate compare:[NSDate date]] == NSOrderedAscending) {
        NSLog(@"inputDate is before current time");
        self.scheduleMessage.text = @"That's coming up quick!";
        
    // otherwise, schedule a notification
    } else {
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = inputDate;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        NSString *ingredientName = [[ingredient objectForKey:@"name"] lowercaseString];
        localNotification.alertBody = [NSString stringWithFormat:@"You're cooking %@ tomorrow!", ingredientName];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE, MMM d, ''yy, h:mm a"];
        NSLog(@"Notification scheduled for %@",[dateFormatter stringFromDate:inputDate]);
        self.scheduleMessage.text = @"Yum! We'll remind you the day before.";
    }
    
    // save scheduled day to Parse
    [currentUser setObject:[inputDate dateByAddingTimeInterval:60*60*24*1] forKey:@"scheduledDay"];
    [currentUser saveInBackground];
    
    // notify feedview to hide banner
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dayScheduled"
                                                        object:nil];
    
}


- (IBAction)dayPressed:(UIButton *)sender {
    
//    NSString *scheduledDay = [currentUser objectForKey:@"scheduledDay"];
    
    [dayOne setSelected:NO];
    [dayTwo setSelected:NO];
    [dayThree setSelected:NO];
    [dayFour setSelected:NO];
    [dayFive setSelected:NO];
    [daySix setSelected:NO];
    [daySeven setSelected:NO];
    [sender setSelected:YES];
    
    
    self.scheduleMessage.text = nil;
    
    if ([sender tag] == 1) {
        NSLog(@"Button pressed: Thursday");
        [self scheduleNotification:[dayOneActual dateByAddingTimeInterval:-60*60*24*1]];
//        [self scheduleNotification:[NSDate dateWithTimeIntervalSinceNow:10]];
        
    } else if ([sender tag] == 2) {
        NSLog(@"Button pressed: Friday");
        [self scheduleNotification:[dayTwoActual dateByAddingTimeInterval:-60*60*24*1]];
        
    } else if ([sender tag] == 3) {
        NSLog(@"Button pressed: Saturday");
        [self scheduleNotification:[dayThreeActual dateByAddingTimeInterval:-60*60*24*1]];
        
    } else if ([sender tag] == 4) {
        NSLog(@"Button pressed: Sunday");
        [self scheduleNotification:[dayFourActual dateByAddingTimeInterval:-60*60*24*1]];
        
    } else if ([sender tag] == 5) {
        NSLog(@"Button pressed: Monday");
        [self scheduleNotification:[dayFiveActual dateByAddingTimeInterval:-60*60*24*1]];
        
    } else if ([sender tag] == 6) {
        NSLog(@"Button pressed: Tuesday");
        [self scheduleNotification:[daySixActual dateByAddingTimeInterval:-60*60*24*1]];
        
    } else if ([sender tag] == 7) {
        NSLog(@"Button pressed: Wednesday");
        [self scheduleNotification:[daySevenActual dateByAddingTimeInterval:-60*60*24*1]];
        
    }
    
    // Show tips after scheduling
    scrollView.hidden = NO;
    tipsHeader.hidden = NO;
    tipsBanner.hidden = NO;
    
}

@end