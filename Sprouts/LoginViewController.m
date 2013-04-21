//
//  loginViewController.m
//  Sprouts
//
//  Created by Laura Wishingrad on 4/10/13.
//  Copyright (c) 2013 Laura Wishingrad. All rights reserved.
//

#import "LoginViewController.h"
#import "SproutsTabBarController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize sprouts, blurb;

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
    
    [sprouts setFont:[UIFont fontWithName:@"MuseoSans-500" size:42.0]];
    [blurb setFont:[UIFont fontWithName:@"MuseoSans-500" size:17.0]];
    
}

//- (IBAction)loginButtonPushed:(UIButton *)sender {
//    sproutsViewController *mainView = [[sproutsViewController alloc] init];
//    [self.navigationController pushViewController:mainView animated:YES];
//}


- (IBAction)loginButtonPushed:(UIButton *)sender {
    // The permissions requested from the user
    NSArray *permissionsArray = @[ @"email"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
            }
        } else {
            
            if (user.isNew) {
                NSLog(@"User signed up and logged in through Facebook!");
            } else {
                NSLog(@"User logged in through Facebook!");
            }
            
            // Create request for user's Facebook data
            FBRequest *request = [FBRequest requestForMe];
            
            // Send request to Facebook
            [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                if (!error) {
                    // result is a dictionary
                    NSDictionary *userData = (NSDictionary *)result;
                    
                    // show all data from Facebook
                    for (id key in userData) {
                        NSLog(@"key: %@, value: %@", key, [userData objectForKey:key]);
                    }
                    
                    // save user data to Parse
                    PFUser *currentUser = [PFUser currentUser];
                    [currentUser setObject:[userData objectForKey:@"first_name"] forKey:@"firstName"];
                    [currentUser setObject:[userData objectForKey:@"last_name"] forKey:@"lastName"];
                    [currentUser setObject:[userData objectForKey:@"email"] forKey:@"email"];
                    
                    NSString *facebookId = userData[@"id"];
                    
                    // save profile pic
                    self.imageData = [[NSMutableData alloc] init];
                    NSURL *profilePictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=240&height=240", facebookId]];
                    NSURLRequest *profilePictureURLRequest = [NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f]; // Facebook profile picture cache policy: Expires in 2 weeks
                    NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:profilePictureURLRequest delegate:self];
                    if (!urlConnection) {
                        NSLog(@"Failed to download picture");
                    }
                    
                    [currentUser saveInBackground];
                    
                }
            }];
            
            [self performSegueWithIdentifier:@"loginToMain" sender:self];
        }
    }];
}

// Asynchronous image download + save to Parse

// Called every time a chunk of the data is received
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.imageData appendData:data]; // Build the image
}

// Called when the entire image is finished downloading
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Set the image in the header imageView
    PFFile *imageFile = [PFFile fileWithName:@"profile.png" data:self.imageData];
    [imageFile saveInBackground];
    PFUser *currentUser = [PFUser currentUser];
    [currentUser setObject:imageFile forKey:@"profilePic"];
    [currentUser saveInBackground];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
