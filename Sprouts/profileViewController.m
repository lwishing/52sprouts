//
//  profileViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/3/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "profileViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface profileViewController ()

@end

@implementation profileViewController

@synthesize settingsButton;
@synthesize childView = _childView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Set background color to clear to make background image visible
    self.view.backgroundColor = [UIColor clearColor];
    
    // configure chld view controller view's frame
    self.childView.view.frame=CGRectMake( 0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height);
    // add child's view to view hierarchy
    [self.view addSubview:self.childView.view];
    
}

-(void)awakeFromNib {
    // instantiate and assign the child view controller to a property to have direct reference to it in
    self.childView=[self.storyboard instantiateViewControllerWithIdentifier:@"mefeed"];
    // configure your child view controller
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
