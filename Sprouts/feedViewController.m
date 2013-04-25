//
//  feedViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/3/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "feedViewController.h"
#import "scheduleViewController.h"
#import "Utility.h"

@interface feedViewController ()
@end

@implementation feedViewController

@synthesize childView = _childView;
@synthesize scheduleBanner = _scheduleBanner;
@synthesize ingredientHeader = _ingredientHeader;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Set background color to clear to make background image visible
    self.view.backgroundColor = [UIColor clearColor];
    
    // Listen to "dayScheduled" event
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dayScheduled:)
                                                 name:@"dayScheduled"
                                               object:nil];
    
    // Set title to Ingredient of the Week
    PFObject *ingredient = [[Utility sharedInstance] getCurrentIngredient];
    self.ingredientHeader.title = [ingredient objectForKey:@"name"];
    
    // configure chld view controller view's frame
    self.childView.view.frame=CGRectMake( 0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height);
    // add child's view to view hierarchy
    [self.view addSubview:self.childView.view];

    
    // figure out this week's localized start date
    NSDate *scheduled = [[PFUser currentUser] objectForKey:@"scheduledDay"];
    PFObject *week = [[Utility sharedInstance] getCurrentWeek];
    NSDate *startDate = [week objectForKey:@"startDate"];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: startDate];
    startDate = [gregorian dateFromComponents:components];
    
    // check dates in console
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE, MMM d, ''yy, h:mm a"];
    NSLog(@"startDate: %@", [dateFormatter stringFromDate:startDate]);
    NSLog(@"scheduled: %@", [dateFormatter stringFromDate:scheduled]);
    
    // if scheduledDay is null, show the banner
    if (scheduled == [NSNull null]) {
        NSLog(@"schelduledDate is null");
        // Bring Schedule Banner to front & make semi-transparent
        [[_scheduleBanner superview] bringSubviewToFront:_scheduleBanner];
        [_scheduleBanner setAlpha:0.80];
    }
    // if scheduledDay is from previous week, clear it out and show the banner
    else if ([scheduled compare:startDate] == NSOrderedAscending) {
        NSLog(@"scheduledDay is before startDate, resetting scheduledDay");
        PFUser *currentUser = [PFUser currentUser];
        [currentUser setObject:[NSNull null] forKey:@"scheduledDay"];
        [currentUser saveInBackground];
        [[_scheduleBanner superview] bringSubviewToFront:_scheduleBanner];
        [_scheduleBanner setAlpha:0.80];
    // if scheduledDay is set for this week, hide the schedule banner
    } else if ([scheduled compare:startDate] == NSOrderedDescending) {
        NSLog(@"scheduledDay current");
        [_scheduleBanner setHidden:TRUE];
    // otherwise, scheduledDate is undefined, show the banner
    } else {
        NSLog(@"schelduledDate is undefined");
        [[_scheduleBanner superview] bringSubviewToFront:_scheduleBanner];
        [_scheduleBanner setAlpha:0.80];
    } 
    
    // Disable middle tab
    [[[[[self tabBarController]viewControllers]objectAtIndex:1]tabBarItem]setEnabled:false];
    
}

- (void)dayScheduled:(NSNotification *)note{
    // listen for action from schedule view
    NSLog(@"Day selected - hide the schedule banner!");
    [_scheduleBanner setHidden:TRUE];
}

-(void)awakeFromNib {
    // instantiate and assign the child view controller to a property to have direct reference to it in
    self.childView=[self.storyboard instantiateViewControllerWithIdentifier:@"thefeed"];
    // configure your child view controller
    // add your child view controller to children array
    [self addChildViewController:self.childView];
    [self.childView didMoveToParentViewController:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
