//
//  sproutsAppDelegate.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/3/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "Utility.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Parse keys
    [Parse setApplicationId:@"rbVL4eTEwdq7DQ3UxDgnBp4G394L9cejopymUPhl"
                  clientKey:@"AjBdyqrKELAXkL59vxk2oaDphjKyC1Vk230jAmi7"];
    
    // Track Parse stats
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    // Initialize Facebook SDK
    [PFFacebookUtils initializeFacebook];
    
    // Override point for customization after application launch.
        
    // Nav bar appearance
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
    UIImage *navBar = [UIImage imageNamed:@"nav_bar"];
    [[UINavigationBar appearance]setBackgroundImage:navBar forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"nav_bar_shadow"]];
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                UITextAttributeTextColor: [UIColor colorWithRed:(43/255.0) green:(36/255.0) blue:(19/255.0) alpha:1.0],
                          UITextAttributeTextShadowColor: [UIColor colorWithRed:(190/255.0) green:(155/255.0) blue:(101/255.0) alpha:1.0],
                         UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)],
                                     UITextAttributeFont: [UIFont fontWithName:@"MuseoSans-700" size:20.0f]
     }];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"MuseoSans-500" size:12.0f], UITextAttributeFont,nil] forState:UIControlStateNormal];
    
    // UI bar button appearance
    [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:(43/255.0) green:(36/255.0) blue:(19/255.0) alpha:1.0]];
    //[[UIBarButtonItem appearance] setTintColor:[UIColor colorWithRed:(108/255.0) green:(79/255.0) blue:(43/255.0) alpha:1.0]];
    
    // Utility - Get Current Week & Ingredient
    Utility *util = [Utility sharedInstance];
    NSString *week = [[util getCurrentWeek] objectForKey:@"week"];
    NSString *ingredientName = [[util getCurrentIngredient] objectForKey:@"name"];
    NSLog(@"Week: %@, Ingredient: %@", week, ingredientName);
    

    return YES;
}

// Handler for Parse + Facebook SDK
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [PFFacebookUtils handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
}
//


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
    
    // Refresh week/ingredient when application becomes active
    Utility *util = [Utility sharedInstance];
    NSString *week = [[util getCurrentWeek] objectForKey:@"week"];
    NSString *ingredientName = [[util getCurrentIngredient] objectForKey:@"name"];
    NSLog(@"Week: %@, Ingredient: %@", week, ingredientName);
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
