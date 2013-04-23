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
@synthesize week;
@synthesize ingredient;
@synthesize dayOneActual;
@synthesize dayTwoActual;
@synthesize dayThreeActual;
@synthesize dayFourActual;
@synthesize dayFiveActual;
@synthesize daySixActual;
@synthesize daySevenActual;
@synthesize dayOne, dayTwo, dayThree, dayFour, dayFive, daySix, daySeven;

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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMM d, ''yy, h:mm a"];
    
    // get current week
    week = [[Utility sharedInstance] getCurrentWeek];
    ingredient = [[Utility sharedInstance] getCurrentIngredient];
    
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
    
    // show date string below each button
    self.dayOneDate.text = [buttonDate stringFromDate:dayOneActual];
    self.dayTwoDate.text =  [buttonDate stringFromDate:dayTwoActual];
    self.dayThreeDate.text = [buttonDate stringFromDate:dayThreeActual];
    self.dayFourDate.text = [buttonDate stringFromDate:dayFourActual];
    self.dayFiveDate.text = [buttonDate stringFromDate:dayFiveActual];
    self.daySixDate.text = [buttonDate stringFromDate:daySixActual];
    self.daySevenDate.text = [buttonDate stringFromDate:daySevenActual];

    
//    dayOfWeek = @"Tuesday";
    
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
    
    if ([inputDate compare:[NSDate date]] == NSOrderedAscending) {
        NSLog(@"inputDate is before current time");
    } else {
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = inputDate;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.alertBody = @"Remember, you're supposed to cook tomorrow! Make sure to go get your ingredients.";
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE, MMM d, ''yy, h:mm a"];
        NSLog(@"Notification scheduled for %@",[dateFormatter stringFromDate:inputDate]);
    }
    
}


- (IBAction)dayPressed:(UIButton *)sender {
    
//    line of code below schedules a notification 10 seconds in future
//    [self scheduleNotification:[NSDate dateWithTimeIntervalSinceNow:10]];
    
    [dayOne setSelected:NO];
    [dayTwo setSelected:NO];
    [dayThree setSelected:NO];
    [dayFour setSelected:NO];
    [dayFive setSelected:NO];
    [daySix setSelected:NO];
    [daySeven setSelected:NO];
    [sender setSelected:YES];
    
    if ([[sender currentTitle] isEqualToString:@"dayOne"]) {
        NSLog(@"Button pressed: Tuesday");
//        [self scheduleNotification:[dayOneActual dateByAddingTimeInterval:-60*60*24*1]];
        [self scheduleNotification:[NSDate dateWithTimeIntervalSinceNow:10]];
        self.scheduleMessage.text = @"Yum! \nWe'll remind you the day before.";
        
        
    } else if ([[sender currentTitle] isEqualToString:@"dayTwo"]) {
        NSLog(@"Button pressed: Wednesday");
        [self scheduleNotification:[dayTwoActual dateByAddingTimeInterval:-60*60*24*1]];
        self.scheduleMessage.text = @"Yum! \nWe'll remind you the day before.";
        
    } else if ([[sender currentTitle] isEqualToString:@"dayThree"]) {
        NSLog(@"Button pressed: Thursday");
        [self scheduleNotification:[dayThreeActual dateByAddingTimeInterval:-60*60*24*1]];
        self.scheduleMessage.text = @"Yum! \nWe'll remind you the day before.";
        
    } else if ([[sender currentTitle] isEqualToString:@"dayFour"]) {
        NSLog(@"Button pressed: Friday");
        [self scheduleNotification:[dayFourActual dateByAddingTimeInterval:-60*60*24*1]];
        self.scheduleMessage.text = @"Yum! \nWe'll remind you the day before.";
        
    } else if ([[sender currentTitle] isEqualToString:@"dayFive"]) {
        NSLog(@"Button pressed: Saturday");
        [self scheduleNotification:[dayFiveActual dateByAddingTimeInterval:-60*60*24*1]];
        self.scheduleMessage.text = @"Yum! \nWe'll remind you the day before.";
        
    } else if ([[sender currentTitle] isEqualToString:@"daySix"]) {
        NSLog(@"Button pressed: Sunday");
        [self scheduleNotification:[daySixActual dateByAddingTimeInterval:-60*60*24*1]];
        self.scheduleMessage.text = @"Yum! \nWe'll remind you the day before.";
        
    }else if ([[sender currentTitle] isEqualToString:@"daySeven"]) {
        NSLog(@"Button pressed: Monday");
        [self scheduleNotification:[daySevenActual dateByAddingTimeInterval:-60*60*24*1]];
        self.scheduleMessage.text = @"Yum! \nWe'll remind you the day before.";
        
    }
}
@end


