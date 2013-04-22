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
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMM d, ''yy, h:mm a"];
    NSLog(@"Today: %@", [dateFormatter stringFromDate:[NSDate date]]);
    
    NSDate *today = [[NSDate alloc] init];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:1];
    // Calculate when, according to Tom Lehrer, World War III will end
    NSDate *tomorrow = [gregorian dateByAddingComponents:offsetComponents
                                                  toDate:today options:0];
    
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

@end
