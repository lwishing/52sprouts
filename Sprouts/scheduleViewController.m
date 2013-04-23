//
//  scheduleViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/9/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "scheduleViewController.h"
#import "Utility.h"


@interface scheduleViewController ()

@end

@implementation scheduleViewController

@synthesize dayOfWeek;
@synthesize todayDate;

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
    
    // Set background color to clear to make background image visible
    self.view.backgroundColor = [UIColor clearColor];
    
    // figure out current day of the week  
    NSDateFormatter *weekday = [[NSDateFormatter alloc] init];
    [weekday setDateFormat:@"EEEE"];
    dayOfWeek = [weekday stringFromDate:[NSDate date]];
    
    NSDateFormatter *buttonDate = [[NSDateFormatter alloc] init];
    [buttonDate setDateFormat:@"M/d"];
    
    // get current week
    PFObject *week = [[[Utility alloc] init] getCurrentWeek];
    
    // create NSDate objects for each day of week
    NSDate *dayOneActual = [week objectForKey:@"startDate"];
    NSDate *dayTwoActual = [dayOneActual dateByAddingTimeInterval:60*60*24*1];
    NSDate *dayThreeActual = [dayOneActual dateByAddingTimeInterval:60*60*24*2];
    NSDate *dayFourActual = [dayOneActual dateByAddingTimeInterval:60*60*24*3];
    NSDate *dayFiveActual = [dayOneActual dateByAddingTimeInterval:60*60*24*4];
    NSDate *daySixActual = [dayOneActual dateByAddingTimeInterval:60*60*24*5];
    NSDate *daySevenActual = [dayOneActual dateByAddingTimeInterval:60*60*24*6];
    
    // show date string below each button
    self.dayOneDate.text = [buttonDate stringFromDate:dayOneActual];
    self.dayTwoDate.text =  [buttonDate stringFromDate:dayTwoActual];
    self.dayThreeDate.text = [buttonDate stringFromDate:dayThreeActual];
    self.dayFourDate.text = [buttonDate stringFromDate:dayFourActual];
    self.dayFiveDate.text = [buttonDate stringFromDate:dayFiveActual];
    self.daySixDate.text = [buttonDate stringFromDate:daySixActual];
    self.daySevenDate.text = [buttonDate stringFromDate:daySevenActual];

    
    dayOfWeek = @"Tuesday";
    
    // disable buttons if day has passed
    if ([dayOfWeek isEqualToString:@"Tuesday"]) {
    } else if ([dayOfWeek isEqualToString:@"Wednesday"]) {
        [self.dayOne setEnabled:NO];
    } else if ([dayOfWeek isEqualToString:@"Thursday"]) {
        [self.dayOne setEnabled:NO];
        [self.dayTwo setEnabled:NO];
    } else if ([dayOfWeek isEqualToString:@"Friday"]) {
        [self.dayOne setEnabled:NO];
        [self.dayTwo setEnabled:NO];
        [self.dayThree setEnabled:NO];
    } else if ([dayOfWeek isEqualToString:@"Saturday"]) {
        [self.dayOne setEnabled:NO];
        [self.dayTwo setEnabled:NO];
        [self.dayThree setEnabled:NO];
        [self.dayFour setEnabled:NO];
    } else if ([dayOfWeek isEqualToString:@"Sunday"]) {
        [self.dayOne setEnabled:NO];
        [self.dayTwo setEnabled:NO];
        [self.dayThree setEnabled:NO];
        [self.dayFour setEnabled:NO];
        [self.dayFive setEnabled:NO];
    } else if ([dayOfWeek isEqualToString:@"Monday"]) {
        [self.dayOne setEnabled:NO];
        [self.dayTwo setEnabled:NO];
        [self.dayThree setEnabled:NO];
        [self.dayFour setEnabled:NO];
        [self.dayFive setEnabled:NO];
        [self.daySix setEnabled:NO];
    }

    // day calculations
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMM d, ''yy, h:mm a"];
    NSLog(@"Today: %@", [dateFormatter stringFromDate:[NSDate date]]);
    
    NSDate *todaydate = [[NSDate alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:1];
    NSDate *tomorrow = [gregorian dateByAddingComponents:offsetComponents
                                                  toDate:todaydate options:0];
    NSLog(@"Tomorrow: %@", [dateFormatter stringFromDate:tomorrow]);
    
    
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: tomorrow];
    tomorrow = [gregorian dateFromComponents:components];
    NSLog(@"Tomorrow normalized: %@", [dateFormatter stringFromDate:tomorrow]);
    
    NSDateComponents *offsetHour = [[NSDateComponents alloc] init];
    [offsetHour setHour:11];
    
    NSDate *tomorrowNoon = [gregorian dateByAddingComponents:offsetHour
                                                      toDate:tomorrow options:0];
    NSLog(@"Tomorrow 11am: %@", [dateFormatter stringFromDate:tomorrowNoon]);
    
    
}
- (IBAction)backButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dayPressed:(UIButton *)sender {
    if ([[sender currentTitle] isEqualToString:@"dayOne"]) {
        NSLog(@"Button pressed: Tuesday");
    } else if ([[sender currentTitle] isEqualToString:@"dayTwo"]) {
        NSLog(@"Button pressed: Wednesday");
    } else if ([[sender currentTitle] isEqualToString:@"dayThree"]) {
        NSLog(@"Button pressed: Thursday");
    } else if ([[sender currentTitle] isEqualToString:@"dayFour"]) {
        NSLog(@"Button pressed: Friday");
    } else if ([[sender currentTitle] isEqualToString:@"dayFive"]) {
        NSLog(@"Button pressed: Saturday");
    } else if ([[sender currentTitle] isEqualToString:@"daySix"]) {
        NSLog(@"Button pressed: Sunday");
    }else if ([[sender currentTitle] isEqualToString:@"daySeven"]) {
        NSLog(@"Button pressed: Monday");
    }
}
@end


