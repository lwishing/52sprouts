//
//  feedViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/3/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "feedViewController.h"
#import "scheduleViewController.h"

@interface feedViewController ()
@end

@implementation feedViewController

@synthesize childView = _childView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Set background color to clear to make background image visible
    self.view.backgroundColor = [UIColor clearColor];
    
    // configure chld view controller view's frame
    self.childView.view.frame=CGRectMake( 0.0f, 116.0f, self.view.bounds.size.width, self.view.bounds.size.height - 116.0f);
    // add child's view to view hierarchy
    [self.view addSubview:self.childView.view];
    
    // Disable middle tab
    [[[[[self tabBarController]viewControllers]objectAtIndex:1]tabBarItem]setEnabled:false];
    
}

-(void)awakeFromNib{
    // instantiate and assign the child view controller to a property to have direct reference to it in
    self.childView=[self.storyboard instantiateViewControllerWithIdentifier:@"thefeed"];
    // configure your child view controller
    self.childView.parseClassName=@"Sprout";
    NSLog(@"sprout?");
    // add your child view controller to children array
    [self addChildViewController:self.childView];
    
    [self.childView didMoveToParentViewController:self];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
