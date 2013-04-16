//
//  sproutsFirstViewController.m
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Set background color to clear to make background image visible
    self.view.backgroundColor = [UIColor clearColor];
        
    // Disable middle tab
    [[[[[self tabBarController]viewControllers]objectAtIndex:1]tabBarItem]setEnabled:false];
    
//    // Programmatically add Schedule button to UI
//    UIButton* scheduleButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *buttonImage = [UIImage imageNamed:@"schedule_button.png"];
//    //    UIImage *highlightImage = [UIImage imageNamed:@"sprout_pressed.png"];
//    scheduleButton.frame = CGRectMake(0.0, 44.0, buttonImage.size.width, buttonImage.size.height);
//    [scheduleButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    //    [sproutButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
//    //    [sproutButton setTitle:@"Sprout" forState:UIControlStateNormal];
//    //    [sproutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [scheduleButton addTarget:self action:@selector(scheduleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:scheduleButton];
    
}

//- (IBAction)scheduleButtonPressed:(UIButton *)sender
//{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
//    scheduleViewController *scheduleController = [storyboard instantiateViewControllerWithIdentifier:@"schedule"];
////    [self setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
////    [self presentViewController:scheduleController animated:YES completion:nil];
//    [self.navigationController pushViewController:scheduleController animated:YES];
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
