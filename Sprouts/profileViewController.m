//
//  profileViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/3/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "profileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Utility.h"

@interface profileViewController ()

@end

@implementation profileViewController

@synthesize settingsButton;
@synthesize sproutsView = _sproutsView;
@synthesize likesView = _likesView;
@synthesize segmentControl = _segmentControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //button
    UIImage *buttonImage = [[UIImage imageNamed:@"button_back"] resizableImageWithCapInsets:UIEdgeInsetsMake(14, 4, 14, 4)];
    [settingsButton setBackgroundImage:buttonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
//    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[[Utility sharedInstance] mediumFont]
//                                                           forKey:UITextAttributeFont];
//    [_segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    // configure chld view controller view's frame
    _sproutsView.view.frame=CGRectMake( 0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height);
    // add child's view to view hierarchy
    [self.view addSubview:_sproutsView.view];
    
    _likesView.view.frame=CGRectMake( 0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:_likesView.view];
    
    _likesView.view.hidden = YES;
    _segmentControl.selectedSegmentIndex = 0;
}

-(void)awakeFromNib {
    // instantiate and assign the child view controller to a property to have direct reference to it in
    _sproutsView=[self.storyboard instantiateViewControllerWithIdentifier:@"mefeed"];
    // configure your child view controller
    // add your child view controller to children array
    [self addChildViewController:_sproutsView];
    [_sproutsView didMoveToParentViewController:self];
    
    _likesView=[self.storyboard instantiateViewControllerWithIdentifier:@"likesfeed"];
    [self addChildViewController:_likesView];
    [_likesView didMoveToParentViewController:self];
}

-(IBAction)segmentChanged:(UISegmentedControl*)sender {
    if (sender.selectedSegmentIndex == 0) {
        _sproutsView.view.alpha = 0;
        _sproutsView.view.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            [_sproutsView.view setAlpha:1.0];
            [_likesView.view setAlpha:0.0];
        } completion:^(BOOL finished){ [_likesView.view setHidden:YES]; }];
    } else {
        _likesView.view.alpha = 0;
        _likesView.view.hidden = NO;
        [UIView animateWithDuration:0.5 animations:^{
            [_likesView.view setAlpha:1.0];
            [_sproutsView.view setAlpha:0.0];
        } completion:^(BOOL finished){ [_sproutsView.view setHidden:YES]; }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
