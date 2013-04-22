//
//  scheduleViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/9/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "scheduleViewController.h"

@interface scheduleViewController ()

@end

@implementation scheduleViewController

@synthesize dayOfWeek;

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
    
//    dayOfWeek = @"Sunday";
    
    if ([dayOfWeek isEqualToString:@"Monday"]) {
        [self.dayOne setEnabled:NO];
        [self.dayTwo setEnabled:NO];
        [self.dayThree setEnabled:NO];
        [self.dayFour setEnabled:NO];
        [self.dayFive setEnabled:NO];
        [self.daySix setEnabled:NO];
    } else if ([dayOfWeek isEqualToString:@"Tuesday"]) {

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

- (IBAction)dayOnePressed:(UIButton *)sender {
    if ([dayOfWeek isEqualToString:@"Monday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Tuesday"]) {
        NSLog(@"cooking tuesday");
    } else if ([dayOfWeek isEqualToString:@"Wednesday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Thursday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Friday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Saturday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Sunday"]) {
        NSLog(@"inactive");
    }
}
- (IBAction)dayTwoPressed:(UIButton *)sender {
    if ([dayOfWeek isEqualToString:@"Monday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Tuesday"]) {
        NSLog(@"cooking wednesday");
    } else if ([dayOfWeek isEqualToString:@"Wednesday"]) {
        NSLog(@"cooking wednesday");
    } else if ([dayOfWeek isEqualToString:@"Thursday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Friday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Saturday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Sunday"]) {
        NSLog(@"inactive");
    }
}
- (IBAction)dayThreePressed:(UIButton *)sender {
    if ([dayOfWeek isEqualToString:@"Monday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Tuesday"]) {
        NSLog(@"cooking thursday");
    } else if ([dayOfWeek isEqualToString:@"Wednesday"]) {
        NSLog(@"cooking thursday");
    } else if ([dayOfWeek isEqualToString:@"Thursday"]) {
        NSLog(@"cooking thursday");
    } else if ([dayOfWeek isEqualToString:@"Friday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Saturday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Sunday"]) {
        NSLog(@"inactive");
    }
}
- (IBAction)dayFourPressed:(UIButton *)sender {
    if ([dayOfWeek isEqualToString:@"Monday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Tuesday"]) {
        NSLog(@"cooking friday");
    } else if ([dayOfWeek isEqualToString:@"Wednesday"]) {
        NSLog(@"cooking friday");
    } else if ([dayOfWeek isEqualToString:@"Thursday"]) {
        NSLog(@"cooking friday");
    } else if ([dayOfWeek isEqualToString:@"Friday"]) {
        NSLog(@"cooking friday");
    } else if ([dayOfWeek isEqualToString:@"Saturday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Sunday"]) {
        NSLog(@"inactive");
    }
}
- (IBAction)dayFivePressed:(UIButton *)sender {
    if ([dayOfWeek isEqualToString:@"Monday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Tuesday"]) {
        NSLog(@"cooking saturday");
    } else if ([dayOfWeek isEqualToString:@"Wednesday"]) {
        NSLog(@"cooking saturday");
    } else if ([dayOfWeek isEqualToString:@"Thursday"]) {
        NSLog(@"cooking saturday");
    } else if ([dayOfWeek isEqualToString:@"Friday"]) {
        NSLog(@"cooking saturday");
    } else if ([dayOfWeek isEqualToString:@"Saturday"]) {
        NSLog(@"cooking saturday");
    } else if ([dayOfWeek isEqualToString:@"Sunday"]) {
        NSLog(@"inactive");
    }
}
- (IBAction)daySixPressed:(UIButton *)sender {
    if ([dayOfWeek isEqualToString:@"Monday"]) {
        NSLog(@"inactive");
    } else if ([dayOfWeek isEqualToString:@"Tuesday"]) {
        NSLog(@"cooking sunday");
    } else if ([dayOfWeek isEqualToString:@"Wednesday"]) {
        NSLog(@"cooking sunday");
    } else if ([dayOfWeek isEqualToString:@"Thursday"]) {
        NSLog(@"cooking sunday");
    } else if ([dayOfWeek isEqualToString:@"Friday"]) {
        NSLog(@"cooking sunday");
    } else if ([dayOfWeek isEqualToString:@"Saturday"]) {
        NSLog(@"cooking sunday");
    } else if ([dayOfWeek isEqualToString:@"Sunday"]) {
        NSLog(@"cooking sunday");
    }
}
- (IBAction)daySevenPressed:(UIButton *)sender {
    if ([dayOfWeek isEqualToString:@"Monday"]) {
        NSLog(@"cooking monday");
    } else if ([dayOfWeek isEqualToString:@"Tuesday"]) {
        NSLog(@"cooking monday");
    } else if ([dayOfWeek isEqualToString:@"Wednesday"]) {
        NSLog(@"cooking monday");
    } else if ([dayOfWeek isEqualToString:@"Thursday"]) {
        NSLog(@"cooking monday");
    } else if ([dayOfWeek isEqualToString:@"Friday"]) {
        NSLog(@"cooking monday");
    } else if ([dayOfWeek isEqualToString:@"Saturday"]) {
        NSLog(@"cooking monday");
    } else if ([dayOfWeek isEqualToString:@"Sunday"]) {
        NSLog(@"cooking monday");
    }
}

@end
