//
//  sproutsAppDelegate.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/3/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "sproutsAppDelegate.h"
#import <Parse/Parse.h>

@implementation sproutsAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Parse keys
    [Parse setApplicationId:@"rbVL4eTEwdq7DQ3UxDgnBp4G394L9cejopymUPhl"
                  clientKey:@"AjBdyqrKELAXkL59vxk2oaDphjKyC1Vk230jAmi7"];
    
    // Track Parse stats
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Override point for customization after application launch.
    
    // Set background image for Nav bar on all views
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
    UIImage *navBar = [UIImage imageNamed:@"nav_bar.png"];
    [[UINavigationBar appearance]setBackgroundImage:navBar forBarMetrics:UIBarMetricsDefault];
    
    // Set background image for app
//    _window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
